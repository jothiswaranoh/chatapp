import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool iscurrentUser;
  const ChatBubble({super.key,required this.message,required this.iscurrentUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: iscurrentUser? Colors.green : Colors.grey.shade500,
        borderRadius: BorderRadius.circular(12),

      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical:5,horizontal: 25),

      child: Text(message,
      style: TextStyle(color: Colors.white),),

    );
  }
}