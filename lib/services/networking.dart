import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/config.dart';
import '../config/config_keys.dart';

class Networks {
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

  Future<Map<dynamic, dynamic>?> getDataByCity(String cityName) async {
    String url = byCity(cityName);
    // print(url);
    http.Response response = await http.get(Uri.parse(url));
    return decodeResponse(response);
  }

  Future<Map<dynamic, dynamic>?> getDataByLatLong(
      double longitude, double latitude) async {
    http.Response response = await http
        .get(Uri.parse(byLatLong(latitude: latitude, longitude: longitude)));
    return decodeResponse(response);
  }

  Map<dynamic, dynamic>? decodeResponse(http.Response response) {
    dynamic resultData;
    if (response.statusCode == 200) {
      resultData = jsonDecode(response.body);
      print("resultData runtime type: ${resultData.runtimeType}");
    } else {
      print("In Decode Response Function");
      print(response.statusCode);
    }
    return resultData as Map<dynamic, dynamic>;
  }
}
