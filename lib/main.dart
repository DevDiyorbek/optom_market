import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:optom_market/presentation/config/root_binding.dart';
import 'package:optom_market/presentation/pages/home_page.dart';

import 'presentation/pages/auth_screens/otp_page.dart';
import 'presentation/pages/auth_screens/select_location_page.dart';
import 'presentation/pages/auth_screens/sign_in_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: RootBinding(),
      routes: {
        'sign_in_page': (context) => const SignInPage(),
        'otp_page': (context) => const Otp(),
        'location_page': (context) => const SelectLocationPage(),
        'home_page': (context) => const HomePage(),
      },
      home: const HomePage()
    );
  }
}
