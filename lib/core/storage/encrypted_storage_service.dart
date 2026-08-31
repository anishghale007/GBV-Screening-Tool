import 'dart:convert';

import 'package:encrypt/encrypt.dart' as encrypt;

import 'package:gbv/core/constants/app_constants.dart';
import 'package:gbv/core/error/exceptions.dart';
import 'package:gbv/core/storage/secure_storage_service.dart';

/// AES-256-CBC encryption/decryption for screening answers.
///
/// The encryption key and IV are stored in [SecureStorageService]
/// (i.e., Android Keystore / iOS Keychain), never alongside the
/// encrypted data file (FR-SEC-01, FR-SEC-02, NFR-SEC-01).
class EncryptedStorageService {
  EncryptedStorageService({required SecureStorageService secureStorage})
    : _secureStorage = secureStorage;

  final SecureStorageService _secureStorage;

  encrypt.Key? _key;
  encrypt.IV? _iv;

  /// Initializes or retrieves the AES-256 key and IV from secure storage.
  Future<void> _ensureKeysLoaded() async {
    if (_key != null && _iv != null) return;

    try {
      final keyBase64 = await _secureStorage.read(
        AppConstants.encryptionKeyKey,
      );
      final ivBase64 = await _secureStorage.read(AppConstants.encryptionIvKey);

      if (keyBase64 == null || ivBase64 == null) {
        // First-time setup: generate new key and IV.
        _key = encrypt.Key.fromSecureRandom(32); // AES-256
        _iv = encrypt.IV.fromSecureRandom(16);

        await _secureStorage.write(
          key: AppConstants.encryptionKeyKey,
          value: _key!.base64,
        );
        await _secureStorage.write(
          key: AppConstants.encryptionIvKey,
          value: _iv!.base64,
        );
      } else {
        _key = encrypt.Key.fromBase64(keyBase64);
        _iv = encrypt.IV.fromBase64(ivBase64);
      }
    } catch (e) {
      throw EncryptionException('Failed to load encryption keys: $e');
    }
  }

  /// Encrypts a JSON-serializable [data] map and returns a base64 string.
  Future<String> encryptData(Map<String, dynamic> data) async {
    await _ensureKeysLoaded();

    try {
      final encrypter = encrypt.Encrypter(
        encrypt.AES(_key!, mode: encrypt.AESMode.cbc),
      );
      final jsonString = jsonEncode(data);
      final encrypted = encrypter.encrypt(jsonString, iv: _iv);
      return encrypted.base64;
    } catch (e) {
      throw EncryptionException('Encryption failed: $e');
    }
  }

  /// Decrypts a base64-encoded [encryptedData] string back to a map.
  Future<Map<String, dynamic>> decryptData(String encryptedData) async {
    await _ensureKeysLoaded();

    try {
      final encrypter = encrypt.Encrypter(
        encrypt.AES(_key!, mode: encrypt.AESMode.cbc),
      );
      final decrypted = encrypter.decrypt64(encryptedData, iv: _iv);
      return jsonDecode(decrypted) as Map<String, dynamic>;
    } catch (e) {
      throw EncryptionException('Decryption failed: $e');
    }
  }

  /// Wipes the encryption keys from secure storage (session cleanup).
  Future<void> clearKeys() async {
    _key = null;
    _iv = null;
    await _secureStorage.delete(AppConstants.encryptionKeyKey);
    await _secureStorage.delete(AppConstants.encryptionIvKey);
  }
}
