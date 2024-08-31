import 'package:flutter/material.dart';
import 'package:optom_market/presentation/pages/auth/otp_page.dart';

import 'auth_functions.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/sign_in_bg.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Welcome to optom",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                      ),
                    ),
                    const Text(
                      "Get your groceries in as fast as one hour",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        navigateToTelegramBot();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const Otp(),
                          ),
                          );
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.white),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/telegram_logo.png",
                            height: 40,
                          ),
                          const SizedBox(width: 8),
                          // Add some spacing between the image and text
                          const Text(
                            "Telegram orqali kirish",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
