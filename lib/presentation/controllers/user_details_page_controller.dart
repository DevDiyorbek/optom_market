import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../utility/secure_storage.dart';

class UserDetailsPageController extends GetxController {
  final SecureStorage _secureStorage = SecureStorage();
  var userData = <String, String?>{}.obs; // Observable map for user data

  // Controllers for TextFields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController telegramUsernameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  Future<void> loadUserData() async {
    userData.value = await _secureStorage.readUserData();

    nameController.text = '${userData['first_name'] ?? ''} ${userData['last_name'] ?? ''}';
    telegramUsernameController.text = userData['username'] ?? '';
    phoneNumberController.text = "+${userData['phone_number'] ?? ''}";
  }

  Future<void> saveUserData() async {
    // Save the updated data to secure storage
  }

  @override
  void onClose() {
    nameController.dispose();
    telegramUsernameController.dispose();
    phoneNumberController.dispose();
    super.onClose();
  }
}
