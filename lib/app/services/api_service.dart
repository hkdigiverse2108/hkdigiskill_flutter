import 'dart:convert';
import 'package:hkdigiskill/app/services/storage_service.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ApiService extends GetxService {
  // Singleton
  static ApiService get to => Get.find<ApiService>();

  String? _getToken() => StorageService().token;

  final GetStorage _storage = GetStorage();

  // BASE URL
  final String baseUrl = "https://yourapi.com/api"; // set your API base here

  // Check internet connectivity
  Future<bool> hasConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  // GET request
  Future<dynamic> get(String endpoint, {Map<String, String>? headers}) async {
    if (!await hasConnection()) throw Exception("No internet connection");

    headers ??= {};
    final token = _getToken();
    if (token!.isNotEmpty) headers['Authorization'] = 'Bearer $token';

    Uri url = Uri.parse('$baseUrl$endpoint');
    try {
      final response = await http.get(url, headers: headers);
      return _handleResponse(response);
    } catch (e) {
      throw Exception("GET error: $e");
    }
  }

  // POST request
  Future<dynamic> post(
    String endpoint, {
    Object? body,
    Map<String, String>? headers,
  }) async {
    if (!await hasConnection()) throw Exception("No internet connection");

    Uri url = Uri.parse('$baseUrl$endpoint');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json', ...?headers},
        body: jsonEncode(body),
      );
      return _handleResponse(response);
    } catch (e) {
      throw Exception("POST error: $e");
    }
  }

  // PUT request
  Future<dynamic> put(
    String endpoint, {
    Object? body,
    Map<String, String>? headers,
  }) async {
    if (!await hasConnection()) throw Exception("No internet connection");

    Uri url = Uri.parse('$baseUrl$endpoint');
    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json', ...?headers},
        body: jsonEncode(body),
      );
      return _handleResponse(response);
    } catch (e) {
      throw Exception("PUT error: $e");
    }
  }

  Future<dynamic> postMultipart(
    String endpoint, {
    Map<String, String>? fields,
    Map<String, String>? headers,
    List<http.MultipartFile>? files,
  }) async {
    if (!await hasConnection()) throw Exception("No internet connection");

    var url = Uri.parse('$baseUrl$endpoint');
    var request = http.MultipartRequest('POST', url);
    if (headers != null) request.headers.addAll(headers);
    if (fields != null) request.fields.addAll(fields);
    if (files != null) request.files.addAll(files);

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Multipart POST error: $e');
    }
  }

  // DELETE request
  Future<dynamic> delete(
    String endpoint, {
    Object? body,
    Map<String, String>? headers,
  }) async {
    if (!await hasConnection()) throw Exception("No internet connection");

    Uri url = Uri.parse('$baseUrl$endpoint');
    try {
      final response = await http.delete(
        url,
        headers: {'Content-Type': 'application/json', ...?headers},
        body: jsonEncode(body),
      );
      return _handleResponse(response);
    } catch (e) {
      throw Exception("DELETE error: $e");
    }
  }

  // Response handler
  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
        'API Error: ${response.statusCode} ${response.reasonPhrase}',
      );
    }
  }

  // Example for local storage with GetStorage
  void saveToStorage(String key, dynamic value) => _storage.write(key, value);

  dynamic readFromStorage(String key) => _storage.read(key);

  void removeFromStorage(String key) => _storage.remove(key);
}
