import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather/views/home_page.dart';
import 'package:weather/views/welcome_page.dart';
import 'package:google_fonts/google_fonts.dart';

import 'controllers/weather_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('weather');
  Get.put(WeatherController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
            centerTitle: true,
            backgroundColor: Colors.teal,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
            iconTheme: IconThemeData(
              color: Colors.white,
            )),
      ),
      getPages: [
        GetPage(
          name: '/',
          page: () => HomePage(),
          transition: Transition.cupertino,
        ),
        GetPage(
          name: '/helpscreen',
          page: () => HelpScreen(),
          transition: Transition.cupertino,
        ),
      ],
      initialRoute: '/helpscreen',
    );
  }
}
