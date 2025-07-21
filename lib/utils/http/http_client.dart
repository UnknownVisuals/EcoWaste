import 'package:get/get.dart';

class REYHttpHelper extends GetConnect {
  static String _baseUrl = 'https://api.greenappstelkom.id/api';

  // Setter method to change the base URL
  static void setBaseUrl(String baseUrl) {
    _baseUrl = baseUrl;
  }

  // Helper method to make a GET request
  Future<Response> getRequest(String endpoint) async {
    return await get(
      '$_baseUrl/$endpoint',
      headers: {'Content-Type': 'application/json', 'x-user-role': 'WARGA'},
    ).timeout(const Duration(seconds: 10));
  }

  // Helper method to make a POST request
  Future<Response> postRequest(
    String endpoint,
    String xUserRole,
    dynamic data,
  ) async {
    return await post(
      '$_baseUrl/$endpoint',
      data,
      headers: {'Content-Type': 'application/json', 'x-user-role': xUserRole},
    ).timeout(const Duration(seconds: 10));
  }

  // Helper method to make a PUT request
  Future<Response> putRequest(String endpoint, dynamic data) async {
    return await put(
      '$_baseUrl/$endpoint',
      data,
      headers: {'Content-Type': 'application/json'},
    ).timeout(const Duration(seconds: 10));
  }

  // Helper method to make a PATCH request
  Future<Response> patchRequest(String endpoint, dynamic data) async {
    return await patch(
      '$_baseUrl/$endpoint',
      data,
      headers: {'Content-Type': 'application/json', 'x-user-role': 'WARGA'},
    ).timeout(const Duration(seconds: 10));
  }

  // Helper method to make a DELETE request
  Future<Response> deleteRequest(String endpoint) async {
    return await delete(
      '$_baseUrl/$endpoint',
    ).timeout(const Duration(seconds: 10));
  }
}
