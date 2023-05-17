import 'package:flutter/material.dart';

import 'my_button.dart';

class DialogBox extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width < 600
        ? MediaQuery.of(context).size.width * 0.7
        : 500;
    return AlertDialog(
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.2,
        width: swidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            iptfield(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyButton(text: "Save", onPressed: onSave),
                MyButton(text: "Cancel", onPressed: onCancel),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TextField iptfield() {
    return TextField(
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      controller: controller,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Task Name",
        labelStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        prefixIcon: Icon(Icons.task),
      ),
    );
  }
}
