import 'package:eco_waste/utils/local_storage/storage_utility.dart';
import 'package:get/get.dart';

class REYHttpHelper extends GetConnect {
  static String _baseUrl = 'https://api.greenappstelkom.id/api';
  static String _sessionCookie = '';
  static final _storage = REYLocalStorage();

  // Setter method to change the base URL
  static void setBaseUrl(String baseUrl) {
    _baseUrl = baseUrl;
  }

  // Setter method to set session cookie
  static Future<void> setSessionCookie(
    Response response, {
    bool persist = true,
  }) async {
    final rawCookie = response.headers?['set-cookie'];
    if (rawCookie != null && rawCookie.isNotEmpty) {
      final index = rawCookie.indexOf(';');
      _sessionCookie = index != -1 ? rawCookie.substring(0, index) : rawCookie;

      // Only persist the session cookie to storage if persist is true (remember me)
      if (persist) {
        await _storage.saveData('sessionCookie', _sessionCookie);
      }
    }
  }

  // Method to load session cookie from storage
  static void loadSessionCookie() {
    final storedCookie = _storage.readData<String>('sessionCookie');
    if (storedCookie != null) {
      _sessionCookie = storedCookie;
    }
  }

  // Method to clear session cookie
  static Future<void> clearSessionCookie() async {
    _sessionCookie = '';
    await _storage.removeData('sessionCookie');
  }

  // Setter headers for HTTP requests
  Map<String, String> setHeaders() {
    return {'Content-Type': 'application/json', 'Cookie': _sessionCookie};
  }

  // Helper method to make a GET request
  Future<Response> getRequest(String endpoint) async {
    return await get(
      '$_baseUrl/$endpoint',
      headers: setHeaders(),
    ).timeout(const Duration(seconds: 10));
  }

  // Helper method to make a POST request
  Future<Response> postRequest(String endpoint, dynamic data) async {
    return await post(
      '$_baseUrl/$endpoint',
      data,
      headers: setHeaders(),
    ).timeout(const Duration(seconds: 10));
  }

  // Helper method to make a PUT request
  Future<Response> putRequest(String endpoint, dynamic data) async {
    return await put(
      '$_baseUrl/$endpoint',
      data,
      headers: setHeaders(),
    ).timeout(const Duration(seconds: 10));
  }

  // Helper method to make a PATCH request
  Future<Response> patchRequest(String endpoint, dynamic data) async {
    return await patch(
      '$_baseUrl/$endpoint',
      data,
      headers: setHeaders(),
    ).timeout(const Duration(seconds: 10));
  }

  // Helper method to make a DELETE request
  Future<Response> deleteRequest(String endpoint) async {
    return await delete(
      '$_baseUrl/$endpoint',
      headers: setHeaders(),
    ).timeout(const Duration(seconds: 10));
  }
}
