import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:optom_market/presentation/config/root_binding.dart';
import 'package:optom_market/presentation/pages/home_page.dart';
import 'package:optom_market/presentation/pages/auth_screens/sign_in_page.dart';
import 'package:optom_market/utility/secure_storage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> _checkAccessToken() async {
    SecureStorage secureStorage = SecureStorage();
    String? token = await secureStorage.read('access_token'); // Replace 'access_token' with your actual access token key
    return token != null;
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: RootBinding(),
      home: FutureBuilder<bool>(
        future: _checkAccessToken(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            if (snapshot.data == true) {
              return const HomePage();
            } else {
              return const SignInPage();
            }
          }
        },
      ),
    );
  }
}
