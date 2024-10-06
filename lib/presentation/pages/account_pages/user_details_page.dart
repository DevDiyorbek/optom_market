import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/user_details_page_controller.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({super.key});

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  final UserDetailsPageController userDetailsController =
      Get.put(UserDetailsPageController());

  @override
  void initState() {
    super.initState();
    userDetailsController.loadUserData(); // Fetch user data on initialization
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        // Use SingleChildScrollView to allow scrolling
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          // User profile data is accessed through userDetailsController.userProfile
          final userProfile = userDetailsController.userProfile.value;

          if (userProfile == null) {
            return const Center(
                child:
                    CircularProgressIndicator()); // Show a loading indicator if data is not yet loaded
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    ClipOval(
                      child: userProfile.image.isNotEmpty
                          ? Image.network(
                              userProfile.image,
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              height: 200,
                              width: 200,
                              color: Colors.grey, // Placeholder color
                              child: const Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                            ),
                    ),
                    IconButton(
                      iconSize: 30,
                      icon: const Icon(Icons.camera_alt),
                      onPressed: () {
                        userDetailsController.pickAndUploadImage();
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                readOnly: true, // Make the name field non-editable
                controller: userDetailsController.nameController..text =
                      '${userProfile.firstName} ${userProfile.lastName ?? ''}',
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
              ),
              TextFormField(
                readOnly: true,
                controller: userDetailsController.telegramUsernameController
                  ..text = userProfile.username ?? "N/A",
                decoration: const InputDecoration(
                  labelText: 'Telegram Username',
                ),
              ),
              TextFormField(
                readOnly: true, // Make the phone number field non-editable
                controller: userDetailsController.phoneNumberController
                  ..text = userProfile.phoneNumber ?? "N/A",
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: userDetailsController.addressController,
                decoration: const InputDecoration(
                  labelText: 'Address',
                ),
              ),
              const SizedBox(height: 20),
              Obx(() {
                return ElevatedButton(
                  onPressed: userDetailsController.isLoading.value
                      ? null // Disable the button while loading
                      : () {
                          userDetailsController
                              .saveUserData(); // Save user data
                        },
                  child: userDetailsController.isLoading.value
                      ? const CircularProgressIndicator() // Show loading indicator
                      : const Text('Save Changes'),
                );
              }),
            ],
          );
        }),
      ),
    );
  }
}
