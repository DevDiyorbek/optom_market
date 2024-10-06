import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../../utility/LogServices.dart';
import '../../utility/secure_storage.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';


class AuthService {
  final String baseUrl = 'https://api.sodiqdev.cloud';
  final SecureStorage _secureStorage = SecureStorage();
  final UrlLauncherPlatform launcher = UrlLauncherPlatform.instance;


  void checkAccessToken(http.Response response) {
    if (response.statusCode == 401){
      refreshAccessToken();
    }
    else if (response.statusCode == 403) {
      logout();
    }
  }

  Future<void> logout() async {
    await _secureStorage.delete('access_token');
    await _secureStorage.delete('refresh_token');
    await _secureStorage.delete('first_name');
    await _secureStorage.delete('phone_number');
    await _secureStorage.delete('image');
    LogService.w('User logged out');
  }

  Future<bool> login(String code) async {
    final SecureStorage secureStorage = SecureStorage();
    await secureStorage.delete('access_token');
    await secureStorage.delete('refresh_token');
    String? name = await secureStorage.read('access');
    LogService.w('Name of the user is : $name');
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({"code": code}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final user = data['user'];
        final accessToken = data['data']['access_token'];
        final refreshToken = data['data']['refresh_token'];

        await secureStorage.saveUserAndTokenData(
          firstName: user['first_name'],
          phoneNumber: user['phone_number'],
          username: user['username'],
          lastName: user['last_name'],
          image: user['image'],
          accessToken: accessToken,
          refreshToken: refreshToken,
        );

        print('Login successful');
        LogService.w('Name of the user is : $name');
        LogService.w("access: ${secureStorage.read('access_token')}");

        return true;
      } else {
        print('Login failed: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error during login: $e');
      return false;
    }
  }




  Future<void> refreshAccessToken() async {
    final refreshToken = await _secureStorage.read('refresh_token');
    if (refreshToken == null) {
      print('No refresh token available');
      return;
    }
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/refresh'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $refreshToken',
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        await _secureStorage.write('access_token', data['access_token']);
        print('Tokens refreshed successfully');
      } else {
        print('Failed to refresh token: ${response.body}');
        logout();
      }
    } catch (e) {
      print('Error during token refresh: $e');
      logout();
    }
  }

  Future<void> navigateToTelegramBot() async {
    const String telegramBotUrl2 = 'https://t.me/MusicLyricsSSbot';
    const String telegramBotUrl = 'tg://resolve?domain=MusicLyricsSSbot';

    bool firstUrlSuccess = await launcher.launchUrl(
      telegramBotUrl,
      const LaunchOptions(mode: PreferredLaunchMode.externalApplication),
    );

    try {
      if (await canLaunch(telegramBotUrl2)) {
        await launch(
          telegramBotUrl2,
          forceSafariVC: false,
          forceWebView: false,
        );
      } else if (!firstUrlSuccess) {
        await launch(
          telegramBotUrl,
          forceSafariVC: false,
          forceWebView: false,
        );
      } else {
        throw Exception('Could not launch $telegramBotUrl or $telegramBotUrl2');
      }
    } catch (e) {
      print('Error launching URL: $e'); // Log or handle the error accordingly
    }
  }
}
