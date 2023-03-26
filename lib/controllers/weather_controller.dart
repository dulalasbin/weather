import 'dart:async';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'dart:convert';

import 'package:get/get.dart';

class WeatherController extends GetxController {
  var box = Hive.box('weather');

  var isLoading = true.obs;
  var cityName = ''.obs;
  var weatherDescription = ''.obs;
  var temperature = 0.0.obs;
  var iconUrl = ''.obs;
  var apiUrl = ''.obs;
  var searchCityName = ''.obs;

  String apiKey = 'f98e87407ac1499f8fd105656232603';

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
  }

  void getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);

      apiUrl.value =
          'http://api.weatherapi.com/v1/current.json?key=$apiKey&q=${position.latitude},${position.longitude}';

      if (box.get('cityName') == null) {
        await getWeatherData();
      } else {
        await getWeatherDataByQuery(box.get('cityName'));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getWeatherData() async {
    try {
      http.Response response = await http.get(Uri.parse(apiUrl.value));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        cityName.value = data['location']['name'];
        weatherDescription.value = data['current']['condition']['text'];
        temperature.value = data['current']['temp_c'];
        iconUrl.value =
            data['current']['condition']['icon'].replaceAll('//', 'http://');

        isLoading.value = false;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  Future getWeatherDataByQuery(String query) async {
    try {
      http.Response response = await http.get(Uri.parse(
          'http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$query'));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        cityName.value = data['location']['name'];
        weatherDescription.value = data['current']['condition']['text'];
        temperature.value = data['current']['temp_c'];
        iconUrl.value =
            data['current']['condition']['icon'].replaceAll('//', 'http://');
        isLoading.value = false;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }
}
