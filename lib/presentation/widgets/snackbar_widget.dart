import 'package:flutter/material.dart';

void showCustomSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {
          // Optionally implement any action on Snackbar action button press
        },
      ),
    ),
  );
}