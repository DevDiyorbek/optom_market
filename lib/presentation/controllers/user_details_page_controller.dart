import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:optom_market/data/datasources/user_service.dart';
import 'package:optom_market/utility/LogServices.dart';
import '../../../utility/secure_storage.dart';
import '../../data/models/user_profile_model.dart';

class UserDetailsPageController extends GetxController {
  final SecureStorage _secureStorage = SecureStorage();
  final UserService _userService = UserService();
  var userProfile = Rxn<UserProfile>(); // Use reactive variable for UserProfile

  // Controllers for TextFields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController telegramUsernameController =
  TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  var isLoading = false.obs; // Observable for loading state

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  Future<void> loadUserData() async {
    addressController.text = (await _secureStorage.read('address')) ?? "";

    UserProfile? profile = await _userService.getUserDetails();
    if (profile != null) {
      userProfile.value = profile;
      nameController.text = '${profile.firstName} ${profile.lastName ?? ''}';
      telegramUsernameController.text = profile.username ?? "N/A";
      phoneNumberController.text = profile.phoneNumber ?? "N/A";
    }
  }

  Future<void> saveUserData() async {
    isLoading.value = true;
    try {
      await _userService.updateUserAddress(addressController.text);
      await _secureStorage.write('address', addressController.text);
      Get.snackbar("Success", "User data saved successfully!");
      LogService.w("address: ${await _secureStorage.read('address')}");
    } catch (e) {
      Get.snackbar("Error", "Failed to save user data: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickAndUploadImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      bool uploadSuccess = await _userService.uploadImage(imageFile);

      if (uploadSuccess) {
        refreshUserData();
      }
    } else {
      print("No image selected.");
    }
  }

  Future<void> refreshUserData() async {
    await loadUserData();
    Get.snackbar("Success", "User data refreshed!");
  }

  @override
  void onClose() {
    nameController.dispose();
    telegramUsernameController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    super.onClose();
  }
}
