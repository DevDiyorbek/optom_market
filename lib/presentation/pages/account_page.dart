import 'package:flutter/material.dart';
import '../../utility/secure_storage.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key, required this.pageController}); // Keep the PageController

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
            mainAxisAlignment: MainAxisAlignment.start, // Align items at the start
            children: [
              // Profile Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Display circular profile image or placeholder
                  ClipOval(
                    child: userData['image'] != null && userData['image']!.isNotEmpty
                        ? Image.network(userData['image']!, height: 50, width: 50, fit: BoxFit.cover)
                        : Container(
                      height: 50,
                      width: 50,
                      color: Colors.grey, // Placeholder color
                      child: const Icon(Icons.person, color: Colors.white), // Placeholder icon
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                    children: [
                      Text(
                        userData['first_name'] ?? 'N/A',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        userData['last_name'] ?? 'N/A', // Display last name
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const Icon(Icons.edit, size: 24), // Edit icon
                ],
              ),
              const Divider(),

              // Other Options
              _accountOption(Icons.shopping_bag_outlined, "Orders"),
              _accountOption(Icons.newspaper_outlined, "My Details"),
              _accountOption(Icons.location_on_outlined, "Delivery Address"),
              _accountOption(Icons.info_outline, "About"),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center, // Center the contents of button
                        children: [
                          const Icon(Icons.logout, size: 30, color: Colors.green),
                          const SizedBox(width: 10),
                          const Text(
                            'Add to Cart', // Update text accordingly to match purpose
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
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
  Widget _accountOption(IconData icon, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(icon),
        Expanded(child: Text(text)), // Allow text to take available space
        const Icon(Icons.arrow_forward_ios), // Arrow icon on the right
      ],
    );
  }
}
