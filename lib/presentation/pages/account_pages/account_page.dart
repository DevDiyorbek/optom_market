import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:optom_market/presentation/pages/account_pages/app_info_page.dart';
import 'package:optom_market/presentation/pages/account_pages/orders_history.dart';
import 'package:optom_market/presentation/pages/account_pages/delivery_address_page.dart';
import 'package:optom_market/presentation/pages/account_pages/user_details_page.dart';
import '../../controllers/account_page_controller.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key, required this.pageController});

  final PageController? pageController;

  @override
  Widget build(BuildContext context) {
    final AccountController accountController = Get.put(AccountController()); // Initialize controller

    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ClipOval(
                      child: accountController.userData['image'] != null &&
                          accountController.userData['image']!.isNotEmpty
                          ? Image.network(accountController.userData['image']!,
                          height: 50, width: 50, fit: BoxFit.cover)
                          : Container(
                        height: 50,
                        width: 50,
                        color: Colors.grey, // Placeholder color
                        child: const Icon(Icons.person,
                            color: Colors.white), // Placeholder icon
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          accountController.userData['first_name'] ?? 'N/A',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          accountController.userData['last_name'] ?? 'N/A',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const Icon(Icons.edit, size: 24), // Edit icon
                  ],
                );
              }),
              const Divider(),

              // Account Options
              _accountOption(Icons.shopping_bag_outlined, "Orders History",
                  const OrdersHistory()),
              const Divider(),
              _accountOption(Icons.newspaper_outlined, "My Details",
                  const UserDetailsPage()),
              const Divider(),
              _accountOption(Icons.location_on_outlined, "Delivery Address",
                  const DeliveryAddressPage()),
              const Divider(),
              _accountOption(Icons.info_outline, "About", const AppInfoPage()),
              const Divider(),

              // Logout/Action Button
              Flexible(
                child: Container(
                  padding: const EdgeInsets.only(bottom: 35),
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        // Call the logout function in the controller
                        await accountController.logout();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: GestureDetector(
                        child: const Row(
                          children: [
                            Icon(Icons.logout, size: 30, color: Colors.green),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Log Out',
                                textAlign: TextAlign.center, // Center the text
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _accountOption(IconData icon, String text, Widget className) {
    return InkWell(
      onTap: () {
        // Use Get.to() for navigation
        Get.to(() => className);
      },
      child: SizedBox(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon),
            Expanded(child: Text(text)), // Allow text to take available space
            const Icon(Icons.arrow_forward_ios), // Arrow icon on the right
          ],
        ),
      ),
    );
  }
}
