import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../utility/LogServices.dart';
import '../../utility/secure_storage.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';


class AuthService {
  final String baseUrl = 'https://api.sodiqdev.cloud';
  final SecureStorage _secureStorage = SecureStorage();
  final UrlLauncherPlatform launcher = UrlLauncherPlatform.instance;

  Future<void> login(String code) async {
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

        await _secureStorage.saveUserAndTokenData(
          firstName: user['first_name'],
          phoneNumber: user['phone_number'],
          username: user['username'],
          lastName: user['last_name'],
          image: user['image'],
          accessToken: accessToken,
          refreshToken: refreshToken,
        );

        print('Login successful');
        String? image = await _secureStorage.read('image');
        LogService.w('Name of the user is : $image');
      } else {
        print('Login failed: ${response.body}');
      }
    } catch (e) {
      print('Error during login: $e');
    }
  }

  Future<void> logout() async {
    await _secureStorage.delete('access_token');
    await _secureStorage.delete('refresh_token');

    print('User logged out.');
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
        await _secureStorage.write('refresh_token', data['refresh_token']);

        print('Tokens refreshed successfully');
      } else {
        print('Failed to refresh token: ${response.body}');
        logout(); // Handle logout if refresh fails
      }
    } catch (e) {
      print('Error during token refresh: $e');
      logout(); // Handle logout if refresh fails
    }
  }

  bool isTokenExpired(String token) {
    // Implement logic to check if the token is expired
    return false; // Placeholder; implement your expiration logic if needed
  }


  Future<void> navigateToTelegramBot() async {
    const String telegramBotUrl = 'tg://resolve?domain=MusicLyricsSSbot';

    if (!await launcher.launchUrl(
      telegramBotUrl,
      const LaunchOptions(mode: PreferredLaunchMode.externalApplication),
    )) {
      throw Exception('Could not launch $telegramBotUrl');
    }
  }
}
