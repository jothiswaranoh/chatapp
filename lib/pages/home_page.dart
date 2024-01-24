// ignore_for_file: prefer_const_constructors

import 'package:groupchat/components/carouselbody.dart';
import 'package:groupchat/components/my_drawer.dart';
import 'package:groupchat/components/my_chat_list.dart';
import 'package:groupchat/pages/chat_page.dart';
import 'package:groupchat/services/chat/chat_service.dart';
import 'package:groupchat/variables/app_colors.dart';
import 'package:flutter/material.dart';
import '../helper/capitalize_text.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final ChatService _chatService = ChatService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      drawer: const MyDrawer(),
      body: _buildBody(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.appBarColor,
      title: const Text(
        'Chatting App',
        style: TextStyle(
          color: AppColors.appTextColor,
          fontWeight: FontWeight.bold,
          fontSize: 28,
        ),
      ),
    );
  }

  PreferredSizeWidget _buildSearchBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(36.0),
      child: Row(
        children: [
          Expanded(
            child:
             Container(
              margin: const EdgeInsets.symmetric(horizontal: 15.0),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.appTextColor),
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                BoxShadow(
                  color: AppColors.appTextColor.withOpacity(0.1), // Shadow color
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 4), // Shadow offset
                ),
              ],
              ),
              child:
               TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        _buildSearchBar(context),
        const SizedBox(height: 10),
        _buildSectionTitle("Group chat", context),
        SizedBox(height: 5),
        CarouselBody(),
        SizedBox(height: 5),

        _buildSectionTitle("Chats", context),
        _buildChatList(),
      ],
    );
  }

  Widget _buildSectionTitle(String title, BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Text(
          title,
          style: const TextStyle(
            color: AppColors.appTextColor,
            fontSize: 25,
          ),
        ),
      ),
    );
  }

  Widget _buildChatList() {
    return Expanded(
      child: StreamBuilder(
        stream: _chatService.getUsersStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: snapshot.data!
                .map<Widget>(
                  (userData) => _buildChatListItem(userData, context),
                )
                .toList(),
          );
        },
      ),
    );
  }

  Widget _buildChatListItem(
      Map<String, dynamic> userData, BuildContext context) {
    return ChatList(
      text: capitalizeText(userData["username"]),
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
      },
    );
  }
}


// decoration: BoxDecoration(
//                 gradient: const LinearGradient(
//                   colors: [
//                     AppColors.appBarColor,
//                     Color.fromARGB(255, 203, 252, 147),
//                   ],
//                 ),
//                 borderRadius: BorderRadius.circular(15.0),
//               ),