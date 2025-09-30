import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// A custom storage utility using flutter_securestorage for secure key-value storage.
class SecureStorage {
  final FlutterSecureStorage storage;

  SecureStorage({required this.storage});

  /// Writes a [value] for the given [key].
  Future<void> write(String key, String value) async {
    if (kDebugMode) {
      debugPrint('[SecureStorage] write: key=$key, value=$value');
    }
    await storage.write(key: key, value: value);
  }

  /// Reads the value for the given [key]. Returns null if not found.
  Future<String?> read(String key) async {
    if (kDebugMode) {
      debugPrint('[SecureStorage] read: key=$key');
    }
    return await storage.read(key: key);
  }

  /// Deletes the value for the given [key].
  Future<void> delete(String key) async {
    if (kDebugMode) {
      debugPrint('[SecureStorage] delete: key=$key');
    }
    await storage.delete(key: key);
  }

  /// Deletes all values.
  Future<void> clear() async {
    if (kDebugMode) {
      debugPrint('[SecureStorage] clear all keys');
    }
    await storage.deleteAll();
  }
}
