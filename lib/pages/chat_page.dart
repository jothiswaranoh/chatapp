import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:groupchat/components/chat_bubble.dart';
import 'package:groupchat/components/my_textfield.dart';
import 'package:groupchat/controller/comman.dart';
import 'package:groupchat/services/chat/chat_service.dart';

class ChatPage extends StatelessWidget {
  final String receivedEmail;
  final String receivedID;

  ChatPage({super.key, required this.receivedEmail, required this.receivedID});

  //final text controller
  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await ChatService().sendMessage(receivedID, _messageController.text);
      _messageController.clear();
    }
  }

  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(receivedEmail)),
      body: Column(
        children: [
          //display all the messages
          Expanded(child: _buildMessageList()),
          //user input
          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    final currentUser = getCurrentUser();
    assert(currentUser != null, "getCurrentUser() should not be null");
    String senderId = currentUser!.uid;
    return StreamBuilder(
        stream: _chatService.getMessages(receivedID, senderId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("error");
          }
          //loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading ..");
          }
          return ListView(
              children: snapshot.data!.docs
                  .map((doc) => _buildMessageItem(doc))
                  .toList());
        });
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final currentUser = getCurrentUser();
    assert(currentUser != null, "getCurrentUser() should not be null");
    bool iscurrentUser = data['senderId'] == currentUser!.uid;
    var alignment =
        iscurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    //align message to the right
    return Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment:
              iscurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            ChatBubble(message: data["message"], iscurrentUser: iscurrentUser)
          ],
        ));
  }

  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Row(
        children: [
          //text field should takup most of the spc
          Expanded(
            child: MyTextfield(
              controller: _messageController,
              hintText: "Type a message",
              obscureText: false,
            ),
          ),
          Container(
            decoration: BoxDecoration(color: Colors.green,
            shape: BoxShape.circle),
            margin: const EdgeInsets.only(right: 25),
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(Icons.arrow_upward,color: Colors.white,),
            ),
          ),
        ],
      ),
    );
  }
}
