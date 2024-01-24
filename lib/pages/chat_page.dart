import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:groupchat/components/chat_bubble.dart';
import 'package:groupchat/components/my_textfield.dart';
import 'package:groupchat/controller/comman.dart';
import 'package:groupchat/services/chat/chat_service.dart';
import '../variables/app_colors.dart';
import '../helper/capitalize_text.dart';

class ChatPage extends StatelessWidget {
  final String receivedEmail;
  final String receivedID;
  final String receivedUsername;

  ChatPage({
    Key? key,
    required this.receivedEmail,
    required this.receivedID,
    required this.receivedUsername,
  }) : super(key: key);

  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(receivedID, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.appBarColor,
          title: Text(
            capitalizeText(receivedUsername),
            style: const TextStyle(
              color: AppColors.appTextColor,
              fontSize: 28,
            ),
          )),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(child: _buildMessageList()),
          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    final currentUser = getCurrentUser();
    if (currentUser == null) {
      // Handle the case where currentUser is null
      return const Text("Error: currentUser is null");
    }

    String senderId = currentUser.uid;

    return StreamBuilder(
      stream: _chatService.getMessages(receivedID, senderId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }

        return ListView(
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final currentUser = getCurrentUser();

    if (currentUser == null) {
      // Handle the case where currentUser is null
      return const Text("Error: currentUser is null");
    }

    bool isCurrentUser = data['senderId'] == currentUser.uid;
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(message: data["message"], isCurrentUser: isCurrentUser),
        ],
      ),
    );
  }

  Widget _buildUserInput() {
    return Container(
      padding: const EdgeInsets.only(bottom: 20.0, right: 10.0, left: 10.0),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.only(left: 15),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Type a message",
                    hintStyle: TextStyle(color: AppColors.blackColor),
                  ),
                  controller: _messageController,
                ),
              ),
              IconButton(
                onPressed: sendMessage,
                icon: const Icon(
                  Icons.send,
                  color: AppColors.appTextColor,
                  size: 30.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
