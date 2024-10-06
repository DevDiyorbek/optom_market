import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' show MediaType;
import '../../utility/LogServices.dart';
import '../../utility/secure_storage.dart';
import '../datasources/auth_service.dart';
import '../models/user_profile_model.dart';

class UserService {
  final String baseUrl = 'https://api.sodiqdev.cloud';
  final SecureStorage _secureStorage = SecureStorage();
  final AuthService _authService;

  UserService({AuthService? authService})
      : _authService = authService ?? AuthService();

  Future<UserProfile?> getUserDetails() async {
    final accessToken = await _secureStorage.read('access_token');
    if (accessToken == null) {
      print('No access token available');
      return null;
    }

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/user/profile'),
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      _authService.checkAccessToken(response);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        LogService.w('User details retrieved: ${data.toString()}');
        return UserProfile.fromJson(data);
      } else {
        print('Failed to fetch user details: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error fetching user details: $e');
      return null;
    }
  }

  Future<bool> uploadImage(File imageFile) async {
    final accessToken = await _secureStorage.read('access_token');
    if (accessToken == null) {
      print('No access token available');
      return false;
    }

    try {
      final request = http.MultipartRequest(
        'PUT',
        Uri.parse('$baseUrl/user/profile/image'),
      );

      request.headers.addAll({
        'accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      });

      request.files.add(await http.MultipartFile.fromPath(
        'image',
        imageFile.path,
        contentType: MediaType('image', 'jpeg'),
      ));

      final response = await request.send();

      _authService.checkAccessToken(response as http.Response);

      if (response.statusCode == 200) {
        print("Image uploaded successfully");
        Get.snackbar("Success", "Profile image updated");
        return true;
      } else {
        print("Failed to upload image: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Error occurred while uploading image: $e");
      return false;
    }
  }

  Future<bool> updateUserAddress(String address) async {
    final accessToken = await _secureStorage.read('access_token');
    if (accessToken == null) {
      print('No access token available');
      return false;
    }

    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/user/profile'),
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'address': address}),
      );

      _authService.checkAccessToken(response);

      if (response.statusCode == 200) {
        print("User address updated successfully");
        return true;
      } else {
        print("Failed to update user address: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Error occurred while updating user address: $e");
      return false;
    }
  }
}
