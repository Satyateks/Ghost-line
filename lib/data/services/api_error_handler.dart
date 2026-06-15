import 'package:dio/dio.dart';

class ApiErrorHandler {
  ApiErrorHandler._();

  static String getMessage(dynamic error) {
    if (error is DioException) {
      if (error.message == 'No internet connection')  return 'No internet connection';
      if (error.type == DioExceptionType.connectionError) return 'Please check your internet connection';
      if (error.type == DioExceptionType.connectionTimeout) return 'Connection timeout. Please try again.'; 
      if (error.type == DioExceptionType.receiveTimeout) return 'Server response timeout. Please try again.'; 
      if (error.type == DioExceptionType.sendTimeout) return 'Request timeout. Please try again.'; 
      if (error.response?.statusCode == 401) return 'Session expired. Please login again.'; 
      if (error.response?.statusCode == 404) return 'Requested data not found.'; 
      if (error.response?.statusCode == 500) return 'Server error. Please try again later.'; 
      final data = error.response?.data;

      if (data is Map) {
        if (data['message'] != null) return data['message'].toString();
        if (data['error'] != null) return data['error'].toString();
      }
      return error.message ?? 'Something went wrong';
    }

    return 'Something went wrong';
  }
}
