import 'dart:developer' as dev;
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:my_utils/cores/constants/index.dart';

class NotificationService {
  final FirebaseMessaging messaging;
  final FlutterLocalNotificationsPlugin localPlugin;
  late GlobalKey<NavigatorState> navigatorKey;

  NotificationService({required this.messaging, required this.localPlugin});

  /// Initialize everything — call this in main() AFTER Firebase.initializeApp()
  Future<void> init({required GlobalKey<NavigatorState> navigatorKey}) async {
    await _initializeLocalNotifications();
    await _requestPermission();
    await _getDeviceToken();

    // 👉 Handle messages when app is in FOREGROUND
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // 👉 Handle when app is in BACKGROUND and user taps notification
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);

    // 👉 Handle when app is TERMINATED and opened via notification
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final RemoteMessage? initialMessage = await messaging.getInitialMessage();
      if (initialMessage != null) {
        _handleNotificationTap(initialMessage);
      }
    });

    // 👉 Set background message handler (MUST be top-level/static)
    FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandler);
  }

  /// Initialize local notifications plugin + create Android channel
  Future<void> _initializeLocalNotifications() async {
    // 📱 Android: Create notification channel (REQUIRED for Android 8+)
    if (Platform.isAndroid) {
      const AndroidNotificationChannel
      androidChannel = AndroidNotificationChannel(
        'general_channel_id', // ID — must match in AndroidNotificationDetails
        'General Notifications', // Name — shown in system settings
        description: 'Channel for general app notifications',
        importance: Importance.max,
        playSound: true,
      );

      // Initialize with Android-specific settings
      // ignore: unused_local_variable
      final AndroidInitializationSettings androidSettings =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      await localPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.createNotificationChannel(androidChannel);
    }

    // 🍏 iOS: Basic settings
    DarwinInitializationSettings iOSsettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    // 🌐 Initialize plugin for both platforms
    final InitializationSettings settings = InitializationSettings(
      android: const AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: iOSsettings,
    );

    await localPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
    );
  }

  /// Request notification permission (handles iOS/Android differences)
  Future<void> _requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    switch (settings.authorizationStatus) {
      case AuthorizationStatus.authorized:
        dev.log('✅ Notification permission granted');
        break;
      case AuthorizationStatus.provisional:
        dev.log('🟡 Notification permission provisional (iOS)');
        break;
      case AuthorizationStatus.denied:
        dev.log('❌ Notification permission denied');
        // TODO: Show dialog guiding user to app settings
        break;
      default:
        dev.log(
          'ℹ️ Notification permission status: ${settings.authorizationStatus}',
        );
    }
  }

  /// Get and log FCM token (send to your backend in real app)
  Future<void> _getDeviceToken() async {
    String? token = await messaging.getToken();
    if (token != null) {
      dev.log('📱 FCM Token: $token');
      // TODO: Send token to your server: ApiService().registerFcmToken(token);
    } else {
      dev.log('❌ Failed to retrieve FCM token');
    }
  }

  /// Handle incoming FCM message when app is in FOREGROUND
  void _handleForegroundMessage(RemoteMessage message) {
    dev.log('🔔 Foreground FCM received: ${message.messageId}');

    final notification = message.notification;
    if (notification != null) {
      _showLocalNotification(
        title: notification.title ?? 'New Notification',
        body: notification.body ?? '',
        payload: message.data['route'] ?? '/',
      );
    }
  }

  /// Handle tap on notification (from background or terminated state)
  void _handleNotificationTap(RemoteMessage message) {
    dev.log('📦 Notification tapped: ${message.data}');
    navigatorKey.currentContext!.goNamed(message.data['route'] ?? '/');
  }

  /// Show local notification (used for foreground messages)
  Future<void> _showLocalNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    // 📱 Android settings
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'general_channel_id', // 👈 MUST match channel ID created above
          'General Notifications',
          channelDescription: 'Channel for general app notifications',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
        );

    // 🍏 iOS settings
    const DarwinNotificationDetails iOSdetails = DarwinNotificationDetails(
      presentSound: true,
    );

    // 🌐 Cross-platform notification details
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iOSdetails,
    );

    // Show notification with unique ID (timestamp)
    await localPlugin.show(
      DateTime.now().millisecondsSinceEpoch % 2147483647, // Unique 32-bit ID
      title,
      body,
      notificationDetails,
      payload: payload, // Used for navigation
    );
  }

  // /// Handle tap on LOCAL notification (iOS callback + Android via onDidReceiveNotificationResponse)
  // Future<void> _onDidReceiveLocalNotification(
  //   int id,
  //   String? title,
  //   String? body,
  //   String? payload,
  // ) async {
  //   dev.log('🍏 iOS: Local notification received in foreground: $title');
  //   // iOS-specific: You can show a custom dialog here if needed
  // }

  /// Handle tap on notification (works for both Android & iOS)
  void _onDidReceiveNotificationResponse(NotificationResponse response) {
    dev.log('🔔 Notification tapped (local or remote): ${response.payload}');

    final route = response.payload ?? '/';
    navigateToScreen(route);
  }

  /// Safely navigate to screen
  void navigateToScreen(String route) {
    if (navigatorKey.currentContext != null) {
      navigatorKey.currentContext!.goNamed(route);
    } else {
      dev.log('❌ Navigator not attached. Cannot navigate to: $route');
    }
  }

  /// Optional: Subscribe to FCM topic
  Future<void> subscribeToTopic(String topic) async {
    await messaging.subscribeToTopic(topic);
    dev.log('✅ Subscribed to topic: $topic');
  }

  /// Optional: Unsubscribe from FCM topic
  Future<void> unsubscribeFromTopic(String topic) async {
    await messaging.unsubscribeFromTopic(topic);
    dev.log('❌ Unsubscribed from topic: $topic');
  }
}

/// 🚨 BACKGROUND HANDLER — MUST be TOP-LEVEL and annotated with @pragma
@pragma('vm:entry-point')
Future<void> _firebaseBackgroundHandler(RemoteMessage message) async {
  dev.log('🌙 Handling background FCM: ${message.messageId}');

  // 🚨 Initialize Firebase for background isolate
  await Firebase.initializeApp();

  // 🚨 Initialize local notifications for background
  final FlutterLocalNotificationsPlugin localPlugin =
      FlutterLocalNotificationsPlugin();

  // Android setup
  if (Platform.isAndroid) {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // Create channel in background too
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'general_channel_id',
      'General Notifications',
      description: 'Channel for general app notifications',
      importance: Importance.max,
    );

    await localPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    await localPlugin.initialize(
      InitializationSettings(android: androidSettings),
    );
  }

  // Show notification
  final notification = message.notification;
  if (notification != null) {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'general_channel_id',
          'General Notifications',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
        );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await localPlugin.show(
      DateTime.now().millisecondsSinceEpoch,
      notification.title ?? 'New Notification',
      notification.body ?? '',
      notificationDetails,
      payload: message.data['route'] ?? '/',
    );
  }
}
