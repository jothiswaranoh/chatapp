import 'package:flutter/material.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

import '../components/carouselbody.dart';
import '../components/my_drawer.dart';
import '../components/my_chat_list.dart';
import '../pages/chat_page.dart';
import '../services/chat/chat_service.dart';
import '../variables/app_colors.dart';
import '../helper/capitalize_text.dart';
import '../components/my_group_chat_model.dart';
import '../model/user_list.dart';
import '../controller/comman.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ChatService _chatService = ChatService();

  String groupName = '';
  List<UserList> selectedUsers = [];

  Future<void> groupChatModel(context) async {
    List<Map<String, dynamic>> userList = await getAllUsernames();
    final items = userList
        .map((userData) => MultiSelectItem<Map<String, dynamic>>(
              userData,
              userData['username'],
            ))
        .toList();

    await _buildBottomSheet(context, items);
  }

  Future<void> _buildBottomSheet(BuildContext context,
      List<MultiSelectItem<Map<String, dynamic>>> items) async {
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  groupName = value;
                },
                decoration: const InputDecoration(
                  labelText: 'Group Name',
                ),
              ),
              const SizedBox(height: 16),
              MultiSelectBottomSheetField<Map<String, dynamic>>(
                initialChildSize: 0.4,
                listType: MultiSelectListType.CHIP,
                searchable: true,
                buttonText: const Text("Member Usernames"),
                title: const Text("Select Member Usernames"),
                items: items,
                onConfirm: (List<Map<String, dynamic>?> values) {
                  values = values.where((element) => element != null).toList();
                  List<Map<String, dynamic>> nonNullableValues =
                      values.cast<Map<String, dynamic>>();
                  if (nonNullableValues.isNotEmpty) {
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
                    offset: const Offset(0, 4), // Shadow offset
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
        const SizedBox(height: 5),
        CarouselBody(),
        const SizedBox(height: 5),
        _buildSectionTitle("Chats", context),
        _buildChatList(),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.appTextColor,
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: AppColors.appTextColor.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(
              Icons.message_rounded,
              color: AppColors.appTextColor,
            ),
            onPressed: () {
              groupChatModel(context);
            },
          ),
        ),
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


 //decoration: BoxDecoration(
//                 gradient: const LinearGradient(
//                   colors: [
//                     AppColors.appBarColor,
//                     Color.fromARGB(255, 203, 252, 147),
//                   ],
//                 ),
//                 borderRadius: BorderRadius.circular(15.0),
//               ),