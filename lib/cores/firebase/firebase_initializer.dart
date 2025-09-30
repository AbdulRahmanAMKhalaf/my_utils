import 'package:firebase_core/firebase_core.dart';

class FirebaseInitializer {
  /// Initialize Firebase with user-provided FirebaseOptions
  static Future<void> init({required FirebaseOptions options}) async {
    await Firebase.initializeApp(options: options);
  }
}
