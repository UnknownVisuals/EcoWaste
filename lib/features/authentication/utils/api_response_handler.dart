import 'package:get/get.dart';

/// API Response model based on the documented API structure
class ApiResponse<T> {
  final String status;
  final T? data;
  final String? message;
  final List<ApiError>? errors;

  ApiResponse({required this.status, this.data, this.message, this.errors});

  bool get isSuccess => status == 'success';
  bool get isError => status == 'error';

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic)? fromJsonT,
  ) {
    return ApiResponse<T>(
      status: json['status'] ?? 'error',
      data: json['data'] != null && fromJsonT != null
          ? fromJsonT(json['data'])
          : json['data'],
      message: json['message'],
      errors: json['errors'] != null
          ? (json['errors'] as List).map((e) => ApiError.fromJson(e)).toList()
          : null,
    );
  }
}

/// API Error model for field-specific errors
class ApiError {
  final String field;
  final String message;

  ApiError({required this.field, required this.message});

  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(field: json['field'] ?? '', message: json['message'] ?? '');
  }
}

/// Response handler utility
class ApiResponseHandler {
  /// Handle standard API response
  static ApiResponse<T> handleResponse<T>(
    Response response,
    T Function(dynamic)? fromJsonT,
  ) {
    try {
      if (response.body != null && response.body is Map<String, dynamic>) {
        return ApiResponse.fromJson(response.body, fromJsonT);
      } else {
        return ApiResponse<T>(
          status: 'error',
          message: 'Invalid response format',
        );
      }
    } catch (e) {
      return ApiResponse<T>(
        status: 'error',
        message: 'Failed to parse response: ${e.toString()}',
      );
    }
  }

  /// Handle HTTP status codes and convert to appropriate messages
  static String getStatusMessage(int statusCode) {
    switch (statusCode) {
      case 200:
        return 'Success';
      case 201:
        return 'Created successfully';
      case 400:
        return 'Bad request - Please check your input';
      case 401:
        return 'Unauthorized - Please login again';
      case 403:
        return 'Forbidden - You don\'t have permission to access this resource';
      case 404:
        return 'Not found - The requested resource was not found';
      case 500:
        return 'Internal server error - Please try again later';
      default:
        return 'An unexpected error occurred';
    }
  }

  /// Handle authentication-specific responses
  static bool isAuthenticationError(int statusCode) {
    return statusCode == 401 || statusCode == 403;
  }

  /// Extract error messages from API response
  static String extractErrorMessage(ApiResponse response) {
    if (response.message != null && response.message!.isNotEmpty) {
      return response.message!;
    }

    if (response.errors != null && response.errors!.isNotEmpty) {
      return response.errors!.map((error) => error.message).join('\n');
    }

    return 'An unknown error occurred';
  }

  /// Check if response indicates validation errors
  static bool hasValidationErrors(ApiResponse response) {
    return response.errors != null && response.errors!.isNotEmpty;
  }

  /// Get validation errors as a map
  static Map<String, String> getValidationErrors(ApiResponse response) {
    final Map<String, String> errors = {};

    if (response.errors != null) {
      for (ApiError error in response.errors!) {
        errors[error.field] = error.message;
      }
    }

    return errors;
  }
}
