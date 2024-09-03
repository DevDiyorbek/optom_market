import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:optom_market/presentation/config/root_binding.dart';
import 'package:optom_market/presentation/pages/SamplePage.dart';
import 'package:optom_market/presentation/pages/home_page.dart';
import 'package:optom_market/presentation/pages/auth/otp_page.dart';
import 'package:optom_market/presentation/pages/auth/select_location_page.dart';
import 'package:optom_market/presentation/pages/shop_page.dart';
import 'package:optom_market/presentation/pages/auth/sign_in_page.dart';

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
      home: const SignInPage()
    );
  }
}


// import 'package:flutter/material.dart';
// import 'data/datasources/auth_service.dart';
//
//
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter JWT Auth Demo',
//       home: AuthDemo(),
//     );
//   }
// }
//
// class AuthDemo extends StatefulWidget {
//   @override
//   _AuthDemoState createState() => _AuthDemoState();
// }
//
// class _AuthDemoState extends State<AuthDemo> {
//   final AuthService _authService = AuthService();
//
//   void _login() async {
//     // Replace 'your_code' with actual input from user login
//     await _authService.login('your_code');
//   }
//
//   void _makeProtectedRequest() async {
//     await _authService.makeAuthenticatedRequest();
//   }
//
//   void _logout() async {
//     await _authService.logout();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('JWT Authentication')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(onPressed: _login, child: Text('Login')),
//             ElevatedButton(onPressed: _makeProtectedRequest,
//                 child: Text('Access Protected Resource')),
//             ElevatedButton(onPressed: _logout, child: Text('Logout')),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
