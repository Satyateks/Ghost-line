import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:ghostline/data/services/services_route.dart';
import '../../core/utils/app_constants.dart';

class ApiService {
  ApiService._();

  static final ApiService instance = ApiService._();

  late final Dio _dio =
      Dio(
          BaseOptions(
            baseUrl: AppConstants.baseUrl,
            connectTimeout: const Duration(
              milliseconds: AppConstants.connectTimeout,
            ),
            receiveTimeout: const Duration(
              milliseconds: AppConstants.receiveTimeout,
            ),
            responseType: ResponseType.json,
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
            },
          ),
        )
        ..interceptors.addAll([
          _networkInterceptor,
          _authInterceptor,
          _errorInterceptor,
        ]);

  Dio get dio => _dio;

  /// Internet check interceptor
  Interceptor get _networkInterceptor {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        try {
          final networkCtrl = Get.find<NetworkController>();
          final connected = await networkCtrl.checkConnection();

          if (!connected) {
            return handler.reject(
              DioException(
                requestOptions: options,
                type: DioExceptionType.connectionError,
                message: 'No internet connection',
              ),
            );
          }

          return handler.next(options);
        } catch (_) {
          return handler.next(options);
        }
      },
    );
  }

  /// Token interceptor
  Interceptor get _authInterceptor {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        final token = StorageService.instance.token;

        if (token != null && token.isNotEmpty) options.headers['Authorization'] = 'Bearer $token';
        return handler.next(options);
      },
    );
  }

  /// Common error interceptor
  Interceptor get _errorInterceptor {
    return InterceptorsWrapper(
      onError: (error, handler) {
        return handler.next(error);
      },
    );
  }

  Future<Response<dynamic>> get(
    String endpoint, {
    Map<String, dynamic>? query,
    Options? options,
  }) async {
    return _dio.get(endpoint, queryParameters: query, options: options);
  }

  Future<Response<dynamic>> post(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? query,
    Options? options,
  }) async {
    return _dio.post(
      endpoint,
      data: data,
      queryParameters: query,
      options: options,
    );
  }

  Future<Response<dynamic>> put(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? query,
    Options? options,
  }) async {
    return _dio.put(
      endpoint,
      data: data,
      queryParameters: query,
      options: options,
    );
  }

  Future<Response<dynamic>> patch(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? query,
    Options? options,
  }) async {
    return _dio.patch(
      endpoint,
      data: data,
      queryParameters: query,
      options: options,
    );
  }

  Future<Response<dynamic>> delete(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? query,
    Options? options,
  }) async {
    return _dio.delete(
      endpoint,
      data: data,
      queryParameters: query,
      options: options,
    );
  }

  Future<Response<dynamic>> uploadFile(
    String endpoint, {
    required String filePath,
    required String fileKey,
    Map<String, dynamic>? data,
  }) async {
    final formData = FormData.fromMap({
      ...?data,
      fileKey: await MultipartFile.fromFile(filePath),
    });

    return _dio.post(endpoint, data: formData);
  }
}
