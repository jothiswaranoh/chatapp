// ignore_for_file: prefer_const_constructors

import 'package:groupchat/components/carouselbody.dart';
import 'package:groupchat/components/my_drawer.dart';
import 'package:groupchat/components/user_tile.dart';
import 'package:groupchat/pages/chat_page.dart';
import 'package:groupchat/services/chat/chat_service.dart';
import 'package:groupchat/services/user_list.dart';
import 'package:groupchat/variables/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
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

    showModalBottomSheet(
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
  values = values.where((element) => element != null).toList();

  // Explicitly cast to the expected type
  List<Map<String, dynamic>> nonNullableValues = values.cast<Map<String, dynamic>>();

  // Ensure that the list is non-null before processing
  if (nonNullableValues.isNotEmpty) {
    // Now you can safely process the non-null values
    selectedUsers = nonNullableValues
        .map((userData) {
          return UserList(
            uid: userData['uid'],
            username: userData['username'],
          );
        })
        .toList();
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
      backgroundColor: AppColors.mainBackground,
      appBar: AppBar(
        backgroundColor: AppColors.mainBackground,
        title: const Text(
          'Chatting App',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 26,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: AppColors.white,
            ),
            onPressed: () {
              groupmodel(context);
            },
          ),
        ],
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
