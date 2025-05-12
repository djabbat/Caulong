// test/api_service_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:caulong_flutter/services/auth_service.dart';
import 'package:caulong_flutter/services/api_service.dart';

class MockDio extends Mock implements Dio {}
class MockAuthService extends Mock implements AuthService {}

void main() {
  late MockDio mockDio;
  late MockAuthService mockAuthService;
  late ApiService apiService;

  setUp(() {
    mockDio = MockDio();
    mockAuthService = MockAuthService();
    apiService = ApiService(dio: mockDio, authService: mockAuthService);
  });

  test('Test GET request with valid token', () async {
    when(mockAuthService.getToken()).thenAnswer((_) async => 'test_token');
    
    when(mockDio.get(
      '/test',
      options: anyNamed('options'),
    )).thenAnswer((_) async => Response(
      data: {'success': true},
      statusCode: 200,
      requestOptions: RequestOptions(path: '/test'),
    ));

    final result = await apiService.get('/test');
    expect(result, {'success': true});
  });
}