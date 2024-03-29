import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:groupchat/components/my_back_button.dart';
import 'package:groupchat/helper/display_message_to_user.dart';

import '../components/my_users_list.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Users",style: TextStyle(color:Theme.of(context).colorScheme.primary),),
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   elevation: 0,
      // ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Users").snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            DisplayMessageToUser("something make the error", context);
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data == null) {
            return const Text("No data");
          }
          final users = snapshot.data!.docs;

          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  left: 12,
                  top: 12,
                ),
                child: Row(
                  children: [
                    MyBackButton(),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: users.length,
                  padding: const EdgeInsets.all(0),
                  itemBuilder: ((context, index) {
                    final user = users[index];
                    String userName = user['username'];
                    String email = user["email"];
                    return MyUsersList(title: userName, subtitle: email);
                  }),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
