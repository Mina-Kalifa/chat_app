import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.addMessage,
  });
  final TextEditingController controller = TextEditingController();
  final Function(String) addMessage;
  @override
  Widget build(BuildContext context) {
    String message;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: (value) {
                message = value;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
                hintText: 'Enter your message',
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              message = controller.text;
              addMessage(message);
              controller.clear();
            },
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
