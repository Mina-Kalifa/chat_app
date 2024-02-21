import 'package:def_app/models/chat_model.dart';
import 'package:flutter/material.dart';

class BubbleChat extends StatelessWidget {
  const BubbleChat({
    Key? key,
    required this.chat,
    required this.isSender,
  }) : super(key: key);

  final ChatModel chat;
  final bool isSender;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(isSender ? 16.0 : 0),
            topRight: Radius.circular(isSender ? 0 : 16.0),
            bottomLeft: Radius.circular(16.0),
            bottomRight: Radius.circular(16.0),
          ),
          color: isSender ? Colors.green : Colors.grey.shade300,
        ),
        child: Text(
          chat.message,
          style: TextStyle(
            color: isSender ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
