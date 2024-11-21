import 'package:get_storage/get_storage.dart';

class StorageService {
  static final _storage = GetStorage();

  // Keys
  static const String _accessTokenKey = 'accessToken';
  static const String _refreshTokenKey = 'refreshToken';

  // Getters and Setters
  static String? get accessToken => _storage.read(_accessTokenKey);
  static String? get refreshToken => _storage.read(_refreshTokenKey);

  static void saveTokens(String accessToken, String refreshToken) {
    _storage.write(_accessTokenKey, accessToken);
    _storage.write(_refreshTokenKey, refreshToken);
  }

  static void clearTokens() {
    _storage.remove(_accessTokenKey);
    _storage.remove(_refreshTokenKey);
  }

  static bool isLoggedIn() {
    return accessToken != null && accessToken!.isNotEmpty && refreshToken != null && refreshToken!.isNotEmpty;
  }
}