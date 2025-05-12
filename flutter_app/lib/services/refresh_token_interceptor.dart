import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_service.dart';

class RefreshTokenInterceptor extends Interceptor {
  final AuthService _authService;

  RefreshTokenInterceptor({required AuthService authService}) : _authService = authService;

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_isUnauthorized(err)) {
      try {
        // Обновляем токен
        await _authService.refreshToken();

        // Получаем новый токен из SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        final newToken = prefs.getString('token');

        // Копируем оригинальные параметры запроса
        final options = Options(
          method: err.requestOptions.method,
          headers: {
            ...err.requestOptions.headers,
            'Authorization': 'Bearer $newToken',
          },
          contentType: err.requestOptions.contentType,
          responseType: err.requestOptions.responseType,
        );

        // Повторяем запрос
        final retryResponse = await Dio().request(
          err.requestOptions.path,
          data: err.requestOptions.data,
          queryParameters: err.requestOptions.queryParameters,
          options: options,
        );

        // Возвращаем успешный результат
        handler.resolve(retryResponse);
      } catch (e) {
        // Если не удалось обновить токен — отклоняем запрос
        handler.reject(err);
      }
    } else {
      // Если ошибка не 401 — просто передаём дальше
      handler.reject(err);
    }
  }

  bool _isUnauthorized(DioException error) {
    return error.response?.statusCode == 401;
  }
}