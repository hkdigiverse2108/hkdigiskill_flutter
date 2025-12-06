import 'package:get/get.dart';
import 'package:hkdigiskill/app/models/settings/settings_model.dart';
import 'package:hkdigiskill/app/services/api_service.dart';
import 'package:hkdigiskill/app/services/storage_service.dart';
import 'package:hkdigiskill/app/utils/api_constants.dart';
import 'package:hkdigiskill/app/utils/globals.dart';

class SettingsService extends GetxService {
  static SettingsService get to => Get.find<SettingsService>();

  final ApiService _apiService = Get.find<ApiService>();
  final StorageService _storage = Get.find<StorageService>();

  // Settings keys for local storage
  static const String _settingsKey = 'app_settings';

  // Settings state
  final RxMap<String, dynamic> _settings = <String, dynamic>{}.obs;

  Map<String, dynamic> get settings => _settings;

  @override
  void onInit() {
    super.onInit();
    // Load cached settings if available
    _loadCachedSettings();
  }

  // Initialize app settings from API
  Future<void> initializeSettings() async {
    try {
      // Call your settings API endpoint
      final response = await _apiService.get('/settings/all');

      if (response != null && response is Map<String, dynamic>) {
        _settings.value = Map<String, dynamic>.from(response['data']);
        // Cache the settings
        await _storage.saveToStorage(_settingsKey, _settings);

        Globals.appSettings = AppSettings.fromJson(response['data']);
      }
    } catch (e) {
      // If API call fails, use cached settings
      print('Failed to fetch settings: $e');
      _loadCachedSettings();
    }
  }

  // Get a specific setting by key
  dynamic getSetting(String key, {dynamic defaultValue}) {
    return _settings[key] ?? defaultValue;
  }

  // Update a setting
  Future<void> updateSetting(String key, dynamic value) async {
    _settings[key] = value;
    // Persist the change
    await _storage.saveToStorage(_settingsKey, _settings);

    // Optionally, you can also send the update to the server
    try {
      await _apiService.post(
        '${ApiConstants.apiVersion}/settings/update',
        body: {'key': key, 'value': value},
      );
    } catch (e) {
      // Handle error or implement retry logic
      print('Failed to update setting on server: $e');
    }
  }

  // Load cached settings from local storage
  void _loadCachedSettings() {
    final cachedSettings = _storage.readFromStorage(_settingsKey);
    if (cachedSettings != null) {
      _settings.value = Map<String, dynamic>.from(cachedSettings);
    }
  }

  // Clear all settings (useful for logout)
  Future<void> clearSettings() async {
    _settings.clear();
    _storage.removeFromStorage(_settingsKey);
  }
}
