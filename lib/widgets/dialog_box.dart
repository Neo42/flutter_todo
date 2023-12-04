import 'package:flutter/material.dart';
import 'package:flutter_todo/widgets/my_button.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController? controller;
  VoidCallback onSaveTask;
  VoidCallback onCancelTask;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSaveTask,
    required this.onCancelTask,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // task input
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add a new task",
              ),
            ),

            // buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(
                  text: "Save",
                  onPressed: onSaveTask,
                ),
                const SizedBox(width: 8),
                MyButton(
                  text: "Cancel",
                  onPressed: onCancelTask,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
