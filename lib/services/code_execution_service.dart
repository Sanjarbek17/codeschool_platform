import 'package:codeschool_platform/constants.dart';
import 'package:dio/dio.dart';

class CodeExecutionService {
  final Dio _dio;

  CodeExecutionService() : _dio = Dio();
  Future<String> executeCode(String code) async {
    final url = '$baseUrl/editor/execute/';
    try {
      final response = await _dio.post(url, data: {'code': code});
      if (response.statusCode == 200) {
        return response.data['output'];
      } else {
        throw Exception('Failed to execute code: ${response.data}');
      }
    } on DioException catch (dioError) {
      print(dioError.error);
      print(dioError.message);
      throw Exception('Error executing code: ${dioError.message}');
    } catch (e) {
      throw Exception('Error executing code: $e');
    }
  }
}
