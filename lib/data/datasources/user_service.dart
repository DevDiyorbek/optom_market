import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' show MediaType; // To specify the type of the file
import '../../utility/LogServices.dart';
import '../../utility/secure_storage.dart';
import '../models/user_profile_model.dart';

class UserService {
  final String baseUrl = 'https://api.sodiqdev.cloud';
  final SecureStorage _secureStorage = SecureStorage();

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
        contentType: MediaType('image', 'jpeg'), // Ensure the content type matches your image's format
      ));

      final response = await request.send();

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
}
