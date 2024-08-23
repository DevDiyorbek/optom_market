import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key, PageController? pageController});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Image(image: image)
                  Column(
                    children: [
                      Text("Sodiqjon Sodiqov")
                    ],
                  ),
                  Icon(Icons.edit, size: 24,)
                ],
              ),
              const Divider(),
              const Row(
                children: [
                  Icon(Icons.shopping_bag_outlined),
                  Text("Orders"),
                  Icon(Icons.arrow_forward_ios)
                ],
              ),
              const Divider(),
              const Row(
                children: [
                  Icon(Icons.newspaper_outlined),
                  Text("My Details"),
                  Icon(Icons.arrow_forward_ios)
                ],
              ),
              const Divider(),
              const Row(
                children: [
                  Icon(Icons.location_on_outlined),
                  Text("Delivery Address"),
                  Icon(Icons.arrow_forward_ios)
                ],
              ),
              const Divider(),
              const Row(
                children: [
                  Icon(Icons.info_outline),
                  Text("About"),
                  Icon(Icons.arrow_forward_ios)
                ],
              ),
              const Divider(),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.only(bottom: 35),
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        alignment: AlignmentDirectional.centerStart,
                        backgroundColor: const Color(0xFFF2F3F2),
                      ),
                      onPressed: () {
                        //TODO
                        // Handle "Log Out" button press
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.logout),
                          Text(
                            'Add to Cart',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
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
}
