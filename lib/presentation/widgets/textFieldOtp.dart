import 'package:flutter/material.dart';

class textFieldOTP extends StatelessWidget {
  final bool first;
  final bool last;

  const textFieldOTP({super.key, required this.first, required this.last});

  @override
  Widget build(BuildContext context) {
    return SizedBox(

      height: 60,
      width: 40,
      child: TextField(
        keyboardType: TextInputType.number,
        autofocus: true,
        onChanged: (value) {
          if (value.length == 1 && !last) {
            FocusScope.of(context).nextFocus();
          }
          if (value.isEmpty && !first) {
            FocusScope.of(context).previousFocus();
          }
        },
        showCursor: false,
        readOnly: false,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        maxLength: 1,
        decoration: InputDecoration(
          counter: const Offstage(),
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
