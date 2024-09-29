import 'package:flutter/material.dart';
class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: controller,
          keyboardType: TextInputType.multiline,
          decoration: const InputDecoration(
            hintText: 'Add a new task',
            filled: true,
          ),
          maxLines: 4,
          maxLength: 80,
          textInputAction: TextInputAction.done,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
            ),
      ),
          actions: [
      TextButton(
      child: const Text('Cancel', style: TextStyle(color: Colors.black)),
      onPressed: () => Navigator.pop(context),
    ),
    TextButton(
      onPressed: onSave,
      child: const Text('Save', style: TextStyle(color: Colors.black)),
),
      ],
    );
  }
}