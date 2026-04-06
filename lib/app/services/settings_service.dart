import 'dart:developer';
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
      final response = await _apiService.get(ApiConstants.settingsEndpoint);

      if (response != null && response['status'] == 200) {
        final data = response['data'];
        Map<String, dynamic>? settingsData;

        if (data is Map<String, dynamic>) {
          settingsData = data;
        } else if (data is List && data.isNotEmpty) {
          settingsData = data[0];
        }

        if (settingsData != null) {
          _settings.assignAll(settingsData);
          // Cache the settings
          await _storage.saveToStorage(_settingsKey, settingsData);
          Globals.appSettings = AppSettings.fromJson(settingsData);
        }
      }
    } catch (e) {
      // If API call fails, use cached settings
      log('Failed to fetch settings: $e');
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
        ApiConstants.updateSettingsEndpoint,
        body: {'key': key, 'value': value},
      );
    } catch (e) {
      // Handle error or implement retry logic
      log('Failed to update setting on server: $e');
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
