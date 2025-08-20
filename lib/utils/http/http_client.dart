import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class REYHttpHelper extends GetConnect {
  static String _baseUrl = 'https://api.greenappstelkom.id/api';
  final GetStorage storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    httpClient.defaultContentType = 'application/json';
    httpClient.timeout = const Duration(seconds: 10);
  }

  // Setter method to change the base URL
  static void setBaseUrl(String baseUrl) {
    _baseUrl = baseUrl;
  }

  // Get headers with authentication if available
  Map<String, String> _getHeaders() {
    Map<String, String> headers = {'Content-Type': 'application/json'};

    // Add cookie from storage if available
    final sessionCookie = storage.read('session_cookie');
    if (sessionCookie != null) {
      headers['Cookie'] = sessionCookie;
    }

    return headers;
  }

  // Helper method to save session cookie
  void _saveSessionCookie(Response response) {
    final cookies = response.headers?['set-cookie'];
    if (cookies != null && cookies.isNotEmpty) {
      // Extract session cookie (connect.sid or similar)
      if (cookies.contains('connect.sid') || cookies.contains('session')) {
        storage.write('session_cookie', cookies.split(';')[0]);
      }
    }
  }

  // Helper method to make a GET request
  Future<Response> getRequest(String endpoint) async {
    final response = await get('$_baseUrl/$endpoint', headers: _getHeaders());
    return response;
  }

  // Helper method to make a POST request with authentication support
  Future<Response> postRequest(
    String endpoint,
    dynamic data, {
    bool saveSession = false,
  }) async {
    final response = await post(
      '$_baseUrl/$endpoint',
      data,
      headers: _getHeaders(),
    );

    if (saveSession && response.statusCode == 200) {
      _saveSessionCookie(response);
    }

    return response;
  }

  // Helper method to make a PUT request
  Future<Response> putRequest(String endpoint, dynamic data) async {
    return await put('$_baseUrl/$endpoint', data, headers: _getHeaders());
  }

  // Helper method to make a PATCH request
  Future<Response> patchRequest(String endpoint, dynamic data) async {
    return await patch('$_baseUrl/$endpoint', data, headers: _getHeaders());
  }

  // Helper method to make a DELETE request
  Future<Response> deleteRequest(String endpoint) async {
    return await delete('$_baseUrl/$endpoint', headers: _getHeaders());
  }

  // Clear session data
  void clearSession() {
    storage.remove('session_cookie');
  }
}
