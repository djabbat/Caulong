import 'package:dio/dio.dart';

class ApiService {
  final Dio dio;

  ApiService(this.dio);

  Future<Response> post(String path, {required Map<String, dynamic> data}) async {
    final response = await dio.post(path, data: data);
    return response;
  }
}