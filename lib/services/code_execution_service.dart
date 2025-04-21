import 'package:codeschool_platform/constants.dart';
import 'package:dio/dio.dart';

class CodeExecutionService {
  final Dio _dio;

  CodeExecutionService() : _dio = Dio();

  Future<Map<String, dynamic>> executeCode(String code) async {
    final url = '$baseUrl/editor/execute/';
    try {
      final response = await _dio.post(url, data: {'code': code});
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to execute code: ${response.data}');
      }
    } on DioException catch (dioError) {
      if (dioError.response != null) {
        // Handle DioError response details if needed
      }
      throw Exception('Error executing code: ${dioError.message}');
    } catch (e) {
      throw Exception('Error executing code: $e');
    }
  }
}
