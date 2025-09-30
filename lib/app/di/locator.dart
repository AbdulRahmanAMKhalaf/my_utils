import 'package:flutter/material.dart';
import 'package:abk_flutter_utils/cores/constants/index.dart';

final locator = GetIt.instance;

Future<void> locatorSetup() async {
  // Core
  locator.registerSingleton<GlobalKey<NavigatorState>>(
    GlobalKey<NavigatorState>(),
  );

  // Storage
  locator.registerSingletonAsync<SharedPreferences>(
    () async => await SharedPreferences.getInstance(),
  );
  locator.registerLazySingleton<CacheHelper>(
    () => CacheHelper(preferences: locator<SharedPreferences>()),
  );
  locator.registerLazySingleton(() => FlutterSecureStorage());
  locator.registerLazySingleton<SecureStorage>(
    () => SecureStorage(storage: locator<FlutterSecureStorage>()),
  );

  // Firebase
  locator.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  locator.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );
  locator.registerLazySingleton<FirebaseMessaging>(
    () => FirebaseMessaging.instance,
  );
  locator.registerLazySingleton<FirebaseCrashlytics>(
    () => FirebaseCrashlytics.instance,
  );
  locator.registerLazySingleton<FirebaseAnalytics>(
    () => FirebaseAnalytics.instance,
  );

  // Networking
  locator.registerLazySingleton<Dio>(
    () => CustomDio(customSecureStorage: locator<SecureStorage>()).createDio(),
  );
  locator.registerLazySingleton<ApiServices>(() => ApiServices(locator<Dio>()));

  // Notifications
  locator.registerLazySingleton<FlutterLocalNotificationsPlugin>(
    () => FlutterLocalNotificationsPlugin(),
  );
  locator.registerLazySingleton<NotificationService>(
    () => NotificationService(
      messaging: locator<FirebaseMessaging>(),
      localPlugin: locator<FlutterLocalNotificationsPlugin>(),
    ),
  );

  // Composite Services
  locator.registerLazySingleton<FirebaseServices>(
    () => FirebaseServices(
      firebaseAuth: locator<FirebaseAuth>(),
      firebaseFirestore: locator<FirebaseFirestore>(),
      secureStorage: locator<SecureStorage>(),
      crashlytics: locator<FirebaseCrashlytics>(),
      analytics: locator<FirebaseAnalytics>(),
    ),
  );
}
