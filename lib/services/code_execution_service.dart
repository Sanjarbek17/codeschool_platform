import 'package:codeschool_platform/constants.dart';
import 'package:dio/dio.dart';

class CodeExecutionService {
  final Dio _dio;

  CodeExecutionService() : _dio = Dio();

  Future<Map<String, dynamic>> executeCode(String code) async {
    print('code: $code');
    final url = '$baseUrl/editor/execute/';
    try {
      final response = await _dio.post(
        url,
        // options: Options(headers: {'Content-Type': 'application/json'}),
        data: {'code': code},
      );
      print('Executing code: $response');
      if (response.statusCode == 200) {
        print('Code executed successfully: ${response.data}');
        return response.data;
      } else {
        throw Exception('Failed to execute code: ${response.data}');
      }
    } on DioException catch (dioError) {
      print('DioError occurred: ${dioError.message}');
      print('DioError type: ${dioError.type}');
      if (dioError.response != null) {
        print('DioError response data: ${dioError.response?.data}');
        print('DioError response headers: ${dioError.response?.headers}');
        print(
          'DioError response status code: ${dioError.response?.statusCode}',
        );
      } else {
        print('DioError has no response.');
      }
      throw Exception('Error executing code: ${dioError.message}');
    } catch (e) {
      print('Unexpected error: $e');
      throw Exception('Error executing code: $e');
    }
  }
}
