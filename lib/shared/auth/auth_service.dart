import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:honak/core/constants/storage_keys.dart';

class AuthService {
  final FlutterSecureStorage _storage;

  AuthService(this._storage);

  Future<String?> getAccessToken() =>
      _storage.read(key: StorageKeys.accessToken);

  Future<String?> getRefreshToken() =>
      _storage.read(key: StorageKeys.refreshToken);

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await Future.wait([
      _storage.write(key: StorageKeys.accessToken, value: accessToken),
      _storage.write(key: StorageKeys.refreshToken, value: refreshToken),
    ]);
  }

  Future<void> saveUserId(String userId) =>
      _storage.write(key: StorageKeys.userId, value: userId);

  Future<String?> getUserId() => _storage.read(key: StorageKeys.userId);

  Future<void> setGuestMode(bool isGuest) =>
      _storage.write(key: StorageKeys.guestMode, value: isGuest.toString());

  Future<bool> isGuestMode() async {
    final value = await _storage.read(key: StorageKeys.guestMode);
    return value == 'true';
  }

  Future<void> clearAll() async {
    await Future.wait([
      _storage.delete(key: StorageKeys.accessToken),
      _storage.delete(key: StorageKeys.refreshToken),
      _storage.delete(key: StorageKeys.userId),
      _storage.delete(key: StorageKeys.guestMode),
      _storage.delete(key: StorageKeys.activePhone),
    ]);
  }

  Future<bool> hasTokens() async {
    final token = await getRefreshToken();
    return token != null && token.isNotEmpty;
  }
}
