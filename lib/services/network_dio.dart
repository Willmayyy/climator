import 'package:dio/dio.dart';

import '../config/config.dart';
import '../config/config_keys.dart';

class NetworksDio {
  Dio dio = Dio();

  String byCity(String city) {
    return '${getBaseURL()}q=$city&appid=${getApiKey()}&units=metric';
  }

  String getBaseURL() {
    final Config config = Config.manager;
    return config.get(ConfigKeys.baseURL);
  }

  String getApiKey() {
    final Config config = Config.manager;
    return config.get(ConfigKeys.apiKey);
  }

  String byLatLong({required double latitude, required double longitude}) {
    return '${getBaseURL()}lat=$latitude&lon=$longitude&appid=${getApiKey()}&units=metric';
  }

  Future<Map<String, dynamic>?> getDataByCity(String cityName) async {
    try {
      final response = await dio.get(byCity(cityName));
      return decodeResponse(response);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        throw Exception('Connection timed out. Please try again later.');
      } else if (e.type == DioErrorType.badResponse) {
        throw Exception('Server error. Please try again later.');
      } else {
        throw Exception('Unknown error occurred. Please try again later.');
      }
    } catch (e) {
      throw Exception('Unknown error occurred. Please try again later.');
    }
  }

  Future<Map<String, dynamic>?> getDataByLatLong(
      double longitude, double latitude) async {
    try {
      final response =
          await dio.get(byLatLong(latitude: latitude, longitude: longitude));
      return decodeResponse(response);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        throw Exception('Connection timed out. Please try again later.');
      } else if (e.type == DioErrorType.badResponse) {
        throw Exception('Server error. Please try again later.');
      } else {
        throw Exception('Unknown error occurred. Please try again later.');
      }
    } catch (e) {
      throw Exception('Unknown error occurred. Please try again later.');
    }
  }

  Map<String, dynamic>? decodeResponse(Response<dynamic> response) {
    dynamic resultData;
    if (response.statusCode == 200) {
      resultData = response.data;
      print("resultData runtime type: ${resultData.runtimeType}");
    } else {
      print("In Decode Response Function");
      print(response.statusCode);
      throw Exception('Server error. Please try again later.');
    }
    return resultData as Map<String, dynamic>;
  }
}
