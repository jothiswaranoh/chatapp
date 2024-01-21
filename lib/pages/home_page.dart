// ignore_for_file: prefer_const_constructors

import 'package:groupchat/components/carouselbody.dart';
import 'package:groupchat/components/my_drawer.dart';
import 'package:groupchat/components/user_tile.dart';
import 'package:groupchat/pages/chat_page.dart';
import 'package:groupchat/services/chat/chat_service.dart';
import 'package:groupchat/variables/app_colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ChatService _chatService = ChatService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      appBar: AppBar(
        backgroundColor:
            AppColors.mainBackground, // Match the Scaffold background color

        title: const Text(
          'Chatting App',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 26,
          ),
        ),
        bottom: PreferredSize(
          preferredSize:
              const Size.fromHeight(36.0), // Adjust the height as needed
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search...',
                      hintStyle: TextStyle(
                          color: Colors.black), // Set the hint text color
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: MyDrawer(),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "Group chat",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  // Add other styles as needed
                ),
              ),
            ),
          ),
          CarouselBody(),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "Chats",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
          ),
          _buildUserList()
        ],
      ),
    );
  }

  Widget _buildUserList() {
    return Expanded(
      child: StreamBuilder(
          stream: _chatService.getUsersStream(),
          builder: (context, snapshot) {
            //if any error
            if (snapshot.hasError) {
              return const Text("error");
            }

            //loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView(
                children: snapshot.data!
                    .map<Widget>(
                        (userData) => _buildUserListItem(userData, context))
                    .toList());
          }),
    );
  }
}

//build each items

Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
  //display expect current user
  //check this email does not equal to the current user.
  return UserTile(
      text: userData["username"],
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ChatPage(
              receivedUsername: userData['username'],
              receivedEmail: userData['email'],
              receivedID: userData['uid'],
            ),
          ),
        );
      });
}
