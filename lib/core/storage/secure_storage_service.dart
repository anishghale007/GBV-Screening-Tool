import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Wrapper around [FlutterSecureStorage] for PIN, duress PIN, and
/// encryption key management.
///
/// Uses Android Keystore / iOS Keychain so keys are never stored
/// alongside the encrypted data (FR-SEC-02, NFR-SEC-02).
class SecureStorageService {
  SecureStorageService({FlutterSecureStorage? storage})
      : _storage = storage ??
            const FlutterSecureStorage(
              aOptions: AndroidOptions(encryptedSharedPreferences: true),
              iOptions: IOSOptions(
                accessibility: KeychainAccessibility.first_unlock,
              ),
            );

  final FlutterSecureStorage _storage;

  /// Reads a value by [key]. Returns `null` if not found.
  Future<String?> read(String key) => _storage.read(key: key);

  /// Writes a [value] for the given [key].
  Future<void> write({required String key, required String value}) =>
      _storage.write(key: key, value: value);

  /// Deletes the value for the given [key].
  Future<void> delete(String key) => _storage.delete(key: key);

  /// Whether a value exists for [key].
  Future<bool> containsKey(String key) => _storage.containsKey(key: key);

  /// Deletes all stored values. Used during session cleanup (FR-SEC-06).
  Future<void> deleteAll() => _storage.deleteAll();
}
