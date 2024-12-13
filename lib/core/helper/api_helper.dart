import 'package:dio/dio.dart';

class ApiHelper {
  final Dio _dio = Dio();

  // POST method
  Future<Response> post(String url, Map<String, dynamic> data) async {
    try {
      var response = await _dio.post(url, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // GET method
  Future<Response> get(String url, {Map<String, String>? headers}) async {
    try {
      return await _dio.get(
        url,
        options: Options(headers: headers),
      );
    } catch (e) {
      rethrow;
    }
  }
}
