// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../components/carouselbody.dart';
import '../components/my_drawer.dart';
import '../components/my_chat_list.dart';
import '../pages/chat_page.dart';
import '../services/chat/chat_service.dart';
import '../variables/app_colors.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import '../helper/capitalize_text.dart';
import '../model/user_list.dart';
import '../controller/comman.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ChatService _chatService = ChatService();
  Future<void> groupmodel(context) async {
    String groupName = '';
    List<UserList> selectedUsers = [];
    List<Map<String, dynamic>> userList = await getAllUsernames();
    final _items = userList
        .map((userData) => MultiSelectItem<Map<String, dynamic>>(
              userData,
              userData['username'],
            ))
        .toList();

    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  groupName = value;
                },
                decoration: InputDecoration(
                  labelText: 'Group Name',
                ),
              ),
              SizedBox(height: 16),
              Column(
                children: <Widget>[
                  MultiSelectBottomSheetField<Map<String, dynamic>>(
                    initialChildSize: 0.4,
                    listType: MultiSelectListType.CHIP,
                    searchable: true,
                    buttonText: Text("Member Usernames"),
                    title: Text("Select Member Usernames"),
                    items: _items,
                    onConfirm: (List<Map<String, dynamic>?> values) {
                      // Remove null values from the list before processing
                      values =
                          values.where((element) => element != null).toList();

                      // Explicitly cast to the expected type
                      List<Map<String, dynamic>> nonNullableValues =
                          values.cast<Map<String, dynamic>>();

                      // Ensure that the list is non-null before processing
                      if (nonNullableValues.isNotEmpty) {
                        // Now you can safely process the non-null values
                        selectedUsers = nonNullableValues.map((userData) {
                          return UserList(
                            uid: userData['uid'],
                            username: userData['username'],
                          );
                        }).toList();
                      }
                    },
                    chipDisplay: MultiSelectChipDisplay(
                      onTap: (value) {
                        setState(() {
                          selectedUsers.remove(value);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

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
      actions: [
        IconButton(
          icon: Icon(
            Icons.add,
            color: AppColors.whiteColor,
          ),
          onPressed: () {
            groupmodel(context);
          },
        ),
      ],
    );
  }

  PreferredSizeWidget _buildSearchBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(36.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15.0),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.appTextColor),
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color:
                        AppColors.appTextColor.withOpacity(0.1), // Shadow color
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 4), // Shadow offset
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
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