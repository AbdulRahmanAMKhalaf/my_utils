import 'package:flutter_core_utils/cores/constants/index.dart';

class FirebaseServices {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final SecureStorage secureStorage;
  final FirebaseCrashlytics crashlytics;
  final FirebaseAnalytics analytics;

  FirebaseServices({
    required this.firebaseAuth,
    required this.firebaseFirestore,
    required this.secureStorage,
    required this.crashlytics,
    required this.analytics,
  });

  Future<UserCredential> loginByEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await analytics.logLogin(loginMethod: 'email');

      secureStorage.write('userID', response.user!.uid);
      return response;
    } on FirebaseAuthException catch (e) {
      crashlytics.recordError(
        e,
        StackTrace.current,
        reason: 'Auth/loginByEmail',
      );

      throw FirebaseFailure(e.message!);
    } catch (e) {
      crashlytics.recordError(
        e,
        StackTrace.current,
        reason: 'Auth/loginByEmail',
      );

      throw FirebaseFailure(e.toString());
    }
  }

  Future<UserCredential> registerByEmail({
    required String email,
    required String userName,
    required String phoneNumber,
    required String password,
  }) async {
    try {
      final response = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await analytics.logSignUp(signUpMethod: 'email');

      firebaseFirestore.collection('users').doc(response.user!.uid).set({
        'email': email,
        'userName': userName,
        'phoneNumber': phoneNumber,
      });
      firebaseAuth.currentUser!.updateDisplayName(userName);
      firebaseAuth.currentUser!.verifyBeforeUpdateEmail(email);
      // firebaseAuth.currentUser!.updatePhoneNumber(phon);
      return response;
    } on FirebaseAuthException catch (e) {
      crashlytics.recordError(
        e,
        StackTrace.current,
        reason: 'Auth/registerByEmail',
      );

      throw FirebaseFailure(e.message!);
    } catch (e) {
      crashlytics.recordError(
        e,
        StackTrace.current,
        reason: 'Auth/registerByEmail',
      );

      throw FirebaseFailure(e.toString());
    }
  }

  Future<void> logout() async {
    try {
      await firebaseAuth.signOut();
      await analytics.logEvent(name: 'user_logout');
    } on FirebaseAuthException catch (e) {
      crashlytics.recordError(e, StackTrace.current, reason: 'Auth/logout');

      throw FirebaseFailure(e.message!);
    } catch (e) {
      crashlytics.recordError(e, StackTrace.current, reason: 'Auth/logout');

      throw FirebaseFailure(e.toString());
    }
  }

  // Stream<List<NotificationModel>> getAllNotifications() {
  //   try {
  //     final response = firebaseFirestore
  //         .collection('notifications')
  //         .snapshots()
  //         .map((snapshot) {
  //           return snapshot.docs.map((doc) {
  //             final data = doc.data();

  //             // ✅ Clean nulls to avoid crashing
  //             final safeData = {
  //               'title': data['title'] ?? '',
  //               'body': data['body'] ?? '',
  //               'isRead': data['isRead'] ?? false,
  //             };
  //             return NotificationModel.fromJson(safeData);
  //           }).toList();
  //         });
  //     return response;
  //   } on FirebaseException catch (e) {
  //     throw ('Erro rbecause==> ${e.message}');
  //   } catch (e) {
  //     throw ('Error because==> ${e.toString()}');
  //   }
  // }
}
