import 'package:flutter/material.dart';

class TextFieldOTP extends StatelessWidget {
  final bool first;
  final bool last;
  final TextEditingController controller;

  const TextFieldOTP({
    Key? key,
    required this.controller,
    required this.first,
    required this.last,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 40,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        autofocus: first, // Only the first field should autofocus
        onChanged: (value) {
          if (value.length == 1 && !last) {
            FocusScope.of(context).nextFocus(); // Move to the next field
          }
          if (value.isEmpty && !first) {
            FocusScope.of(context).previousFocus(); // Move to the previous field
          }
        },
        showCursor: true, // Show cursor for better user feedback
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        maxLength: 1,
        decoration: InputDecoration(
          counterText: '', // Hides the counter text
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: Colors.black12),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: Colors.purple),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
