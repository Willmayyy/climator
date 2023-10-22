import 'package:dio/dio.dart';

import '../config/config.dart';
import '../config/config_keys.dart';


class NetworksDio {
  static const String urlDomain =
      'https://api.openweathermap.org/data/2.5/weather?';

  Dio dio = Dio();

  String byCity(String city) {
    return '${urlDomain}q=$city&appid=${getApiKey()}&units=metric';
  }

  String getApiKey() {
    final Config config = Config.manager;
    return config.get(ConfigKeys.apiKey);
  }

  String byLatLong({required double latitude, required double longitude}) {
    return '${urlDomain}lat=$latitude&lon=$longitude&appid=${getApiKey()}&units=metric';
  }

  Future<Map<String, dynamic>?> getDataByCity(String cityName) async {
    try {
      final response = await dio.get(byCity(cityName));
      return decodeResponse(response);
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  Future<Map<String, dynamic>?> getDataByLatLong(
      double longitude, double latitude) async {
    try {
      final response = await dio.get(byLatLong(latitude: latitude, longitude: longitude));
      return decodeResponse(response);
    } catch (e) {
      print("Error: $e");
      return null;
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
    }
    return resultData as Map<String, dynamic>;
  }
}
