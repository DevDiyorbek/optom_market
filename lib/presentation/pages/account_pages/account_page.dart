import 'package:flutter/material.dart';
import 'package:optom_market/presentation/pages/account_pages/app_info_page.dart';
import 'package:optom_market/presentation/pages/cart_pages/cart_page.dart';
import 'package:optom_market/presentation/pages/account_pages/delivery_address_page.dart';
import 'package:optom_market/presentation/pages/account_pages/user_details_page.dart';
import '../../../utility/secure_storage.dart';
import '../auth/otp_page.dart';

class AccountPage extends StatefulWidget {
  const AccountPage(
      {super.key, required this.pageController}); // Keep the PageController

  final PageController? pageController; // Declaring the PageController

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final SecureStorage _secureStorage = SecureStorage();
  Map<String, String?> userData = {};

  Future<void> _loadUserData() async {
    userData = await _secureStorage.readUserData();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ClipOval(
                    child: userData['image'] != null &&
                            userData['image']!.isNotEmpty
                        ? Image.network(userData['image']!,
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
                    // Align text to the left
                    children: [
                      Text(
                        userData['first_name'] ?? 'N/A',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        userData['last_name'] ?? 'N/A',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const Icon(Icons.edit, size: 24), // Edit icon
                ],
              ),
              const Divider(),

              // Other Options
              _accountOption(Icons.shopping_bag_outlined, "Orders", const CartPage()),
              const Divider(),

              _accountOption(Icons.newspaper_outlined, "My Details", const UserDetailsPage()),
              const Divider(),

              _accountOption(Icons.location_on_outlined, "Delivery Address", const DeliveryAddressPage()),
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
                      onPressed: () {
                        // Your onPressed action for logout or other tasks here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
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
            ],
          ),
        ),
      ),
    );
  }

  // Helper method for creating account option rows
  Widget _accountOption(IconData icon, String text, Widget className) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => className,
          ),
        );
      },
      child: Container(
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
