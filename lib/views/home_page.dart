import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/weather_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController search = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed('/helpscreen');
            },
            icon: const Icon(
              Icons.help_outline_rounded,
            ),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(12),
        child: GetX<WeatherController>(builder: (weatherController) {
          if (weatherController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: search,
                        onFieldSubmitted: (value) {
                          weatherController.getWeatherDataByQuery(value);
                          weatherController.box.put(
                            'cityName',
                            value.toString(),
                          );
                          search.clear();
                        },
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          labelStyle: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.w500,
                          ),
                          hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Colors.teal,
                              width: 2.0,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          hintText: 'Enter City Name',
                        ),
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsetsDirectional.symmetric(horizontal: 12),
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        color: Colors.teal,
                        onPressed: () {
                          weatherController
                              .getWeatherDataByQuery(search.text.toString());

                          weatherController.box.put(
                            'cityName',
                            search.text.toString(),
                          );
                          search.clear();
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            weatherController.box.get('cityName') == null
                                ? 'Save'
                                : 'Update',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  weatherController.cityName.value,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  weatherController.weatherDescription.value,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                Image.network(
                  weatherController.iconUrl.value,
                ),
                const SizedBox(height: 10),
                Text(
                  '${weatherController.temperature.value}°',
                  style: const TextStyle(fontSize: 50),
                ),
                const SizedBox(height: 10),
              ],
            );
          }
        }),
      ),
    );
  }
}
