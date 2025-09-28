import 'package:get_storage/get_storage.dart';

class StorageService {
  static final _storage = GetStorage();

  // Keys
  static const String _accessTokenKey = 'accessToken';
  static const String _refreshTokenKey = 'refreshToken';
  static const String _userId = 'userId';

  // Getters and Setters
  static String? get accessToken => _storage.read(_accessTokenKey);

  static String? get refreshToken => _storage.read(_refreshTokenKey);

  static String? get userId => _storage.read(_userId);

  static void saveUserData(String accessToken, String refreshToken, userId) {
    _storage.write(_accessTokenKey, accessToken);
    _storage.write(_refreshTokenKey, refreshToken);
    _storage.write(_userId, userId);
  }

  static void clearTokens() {
    _storage.remove(_accessTokenKey);
    _storage.remove(_refreshTokenKey);
    _storage.remove(_userId);
  }

  static bool isLoggedIn() {
    return accessToken != null &&
        accessToken!.isNotEmpty &&
        refreshToken != null &&
        refreshToken!.isNotEmpty;
  }
}
