import 'package:flutter/material.dart';

class EditFieldDialog extends StatelessWidget {
  final String fieldName;
  final String currentValue;
  final Function(String) updateField;

  const EditFieldDialog({
    Key? key,
    required this.fieldName,
    required this.currentValue,
    required this.updateField,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController(text: currentValue);

    return AlertDialog(
      title: Text('Edit $fieldName'),
      content: TextField(
        controller: controller,
        decoration: InputDecoration(hintText: 'Enter new $fieldName'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            updateField(controller.text); // Call the update function
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
