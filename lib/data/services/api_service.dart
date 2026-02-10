import 'package:dio/dio.dart';
import '../models/stat_model.dart';

class ApiService {
  late final Dio _dio;

  ApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.example.com', // Replace with your actual API base URL
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add interceptors for logging and error handling
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add authentication token if available
          // options.headers['Authorization'] = 'Bearer $token';
          print('REQUEST: ${options.method} ${options.uri}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('RESPONSE: ${response.statusCode} ${response.data}');
          return handler.next(response);
        },
        onError: (error, handler) {
          print('ERROR: ${error.message}');
          // Handle common errors
          if (error.response?.statusCode == 401) {
            // Handle unauthorized access
            print('Unauthorized - Redirect to login');
          } else if (error.response?.statusCode == 500) {
            // Handle server error
            print('Server error');
          }
          return handler.next(error);
        },
      ),
    );
  }

  // Get statistics data from API
  Future<List<StatModel>> getStatistics() async {
    try {
      final response = await _dio.get('/statistics');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] as List<dynamic>;
        return data.map((json) => StatModel.fromJson(json)).toList();
      }
      throw Exception('Failed to load statistics');
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  // Get single stat by ID
  Future<StatModel> getStatById(String id) async {
    try {
      final response = await _dio.get('/statistics/$id');

      if (response.statusCode == 200) {
        return StatModel.fromJson(response.data['data']);
      }
      throw Exception('Failed to load stat');
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  // Handle Dio errors
  String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timeout. Please check your internet connection.';
      case DioExceptionType.badResponse:
        return 'Server error: ${error.response?.statusCode}';
      case DioExceptionType.cancel:
        return 'Request was cancelled.';
      case DioExceptionType.unknown:
        return 'Network error: ${error.message}';
      default:
        return 'An unexpected error occurred.';
    }
  }

  // Set authentication token
  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  // Clear authentication token
  void clearAuthToken() {
    _dio.options.headers.remove('Authorization');
  }
}
