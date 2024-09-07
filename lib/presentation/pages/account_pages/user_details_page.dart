import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/user_details_page_controller.dart';

class UserDetailsPage extends StatelessWidget {
  const UserDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final UserDetailsPageController userDetailsController =
        Get.put(UserDetailsPageController());

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    ClipOval(
                      child: userDetailsController.userData['image'] != null &&
                              userDetailsController
                                  .userData['image']!.isNotEmpty
                          ? Image.network(
                              userDetailsController.userData['image']!,
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              height: 250,
                              width: 250,
                              color: Colors.grey, // Placeholder color
                              child: const Icon(
                                Icons.person,
                                color: Colors.white,
                              ), // Placeholder icon
                            ),
                    ),
                    IconButton(
                      iconSize: 30,
                      icon: const Icon(Icons.camera_alt),
                      onPressed: () {
                        // Implement profile picture change functionality
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: userDetailsController.nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
              ),
              TextFormField(
                controller: userDetailsController.telegramUsernameController,
                decoration: const InputDecoration(
                  labelText: 'Telegram Username',
                ),
                keyboardType:
                    TextInputType.text, // Changed to text for usernames
              ),
              TextFormField(
                controller: userDetailsController.phoneNumberController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                ),
                keyboardType:
                    TextInputType.phone, // Changed to phone for phone numbers
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  userDetailsController
                      .saveUserData(); // Implement saving functionality
                },
                child: const Text('Save Changes'),
              ),
            ],
          );
        }),
      ),
    );
  }
}
