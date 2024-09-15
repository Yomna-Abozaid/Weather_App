import 'package:dio/dio.dart';
import 'end_point.dart';


class ApiService {
  final String apiKey = '81cb23ffb2d6b49ba577220f3c73c48d';
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> getAllWeather(String city) async {
    try {
      final response = await _dio.get(
        '${EndPoints.beseurl}${EndPoints.Forecast}',
        queryParameters: {
          'q': city,
          'appid': apiKey,
          'units': 'metric',
        },
      );
      return response.data;
    } catch (e) {
      if (e is DioException) {
        print('DioException: ${e.message}');
        print('Response status code: ${e.response?.statusCode}');
        print('Response data: ${e.response?.data}');
      } else {
        print('Unknown error: $e');
      }
      return {};
    }
  }
}
