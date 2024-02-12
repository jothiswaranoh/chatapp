// group_chat_model.dart
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import '../model/user_list.dart';
import '../controller/comman.dart';

class GroupChatModel {
  static Future<void> showBottomSheet({
    required BuildContext context,
    required Function(String) onGroupNameChanged,
    required Function(List<UserList>) onUsersSelected,
  }) async {
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
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  onGroupNameChanged(value);
                },
                decoration: const InputDecoration(
                  labelText: 'Group Name',
                ),
              ),
              const SizedBox(height: 16),
              Column(
                children: <Widget>[
                  MultiSelectBottomSheetField<Map<String, dynamic>>(
                    initialChildSize: 0.4,
                    listType: MultiSelectListType.CHIP,
                    searchable: true,
                    buttonText: const Text("Member Usernames"),
                    title: const Text("Select Member Usernames"),
                    items: _items,
                    onConfirm: (List<Map<String, dynamic>?> values) {
                      values =
                          values.where((element) => element != null).toList();

                      List<Map<String, dynamic>> nonNullableValues =
                          values.cast<Map<String, dynamic>>();

                      if (nonNullableValues.isNotEmpty) {
                        selectedUsers = nonNullableValues.map((userData) {
                          return UserList(
                            uid: userData['uid'],
                            username: userData['username'],
                          );
                        }).toList();
                        onUsersSelected(selectedUsers);
                      }
                    },
                    chipDisplay: MultiSelectChipDisplay(
                      onTap: (value) {
                        // Handle chip tap
                        // You can call a callback or modify the state here
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
}
