import 'package:get_storage/get_storage.dart';

class StorageService {
  // Singleton setup
  static final StorageService _instance = StorageService._internal();

  factory StorageService() => _instance;

  StorageService._internal();

  final GetStorage _box = GetStorage();

  // Keys (declare all keys here)
  static const String keySeenOnboarding = 'seenOnboarding';
  static const String keyIsLoggedIn = 'isLoggedIn';
  static const String keyUserData = 'userData';
  static const String keyToken = 'token';

  // Onboarding
  bool get seenOnboarding => _box.read(keySeenOnboarding) ?? false;

  set seenOnboarding(bool value) => _box.write(keySeenOnboarding, value);

  // Login
  bool get isLoggedIn => _box.read(keyIsLoggedIn) ?? false;

  set isLoggedIn(bool value) => _box.write(keyIsLoggedIn, value);

  // User data: can be Map or model as JSON
  dynamic get userData => _box.read(keyUserData);

  set userData(dynamic value) => _box.write(keyUserData, value);

  String get token => _box.read(keyToken) ?? '';

  set token(String value) => _box.write(keyToken, value);

  void clearUserData() {
    _box.remove(keyUserData);
    isLoggedIn = false;
  }

  void clearAll() => _box.erase();

  // Save any key-value pair to storage
  Future<void> saveToStorage(String key, dynamic value) async {
    await _box.write(key, value);
  }

  // Read any key-value pair from storage
  dynamic readFromStorage(String key) {
    return _box.read(key);
  }

  // Remove any key-value pair from storage
  void removeFromStorage(String key) {
    _box.remove(key);
  }
}
