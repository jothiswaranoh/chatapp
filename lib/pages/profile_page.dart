// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groupchat/components/my_back_button.dart';
import 'package:groupchat/components/my_textfield_edit.dart';
import 'package:groupchat/controller/comman.dart';
import 'package:groupchat/model/firestore.dart';
import '../components/my_users_list.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseDatabase database = FirebaseDatabase();

  final usersCollection = FirebaseFirestore.instance.collection("Users");

  User? currentUser = getCurrentUser();

  // Future<void> editField(BuildContext context, String field) async {
  Future<void> editField(BuildContext context, String field) async {
    String newValue = ''; // Initialize newValue with an empty string
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Edit $field",
          style: TextStyle(color: Colors.white),
        ),
        content: TextField(
          autofocus: true,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Enter new $field",
            hintStyle: TextStyle(color: Colors.grey),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog without updating
            },
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .pop(newValue); // Close the dialog with the value
              // Only update the value if 'Save' was pressed
              if (newValue.trim().isNotEmpty) {
                usersCollection
                    .doc(currentUser!.email)
                    .update({field: newValue});
                print('New value: $newValue');
                setState(() {});
              }
            },
            child: Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getuserdetails(currentUser!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.hasData) {
            return buildUserProfile(context, snapshot.data!.data());
          } else {
            return Text("No data received");
          }
        },
      ),
    );
  }

  Widget buildUserProfile(BuildContext context, Map<String, dynamic>? user) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 12,
              top: 12,
            ),
            child: Row(
              children: const [
                MyBackButton(),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(24),
            ),
            padding: const EdgeInsets.all(25),
            child: const Icon(
              Icons.person,
              size: 64,
            ),
          ),
          SizedBox(height: 25),
          Text(
            user?['username'] ?? 'Username not available',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 25),

          Text(
            user?['email'] ?? 'Email not available',
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 50),

          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text("My Details",
                style: TextStyle(color: Color.fromARGB(255, 215, 215, 215))),
          ),
          //username
          MyTextFieldEdit(
            text: user?['username'],
            sectionName: 'Username',
            onPressed: () => editField(context, 'username'),
          ),
          //bio
          MyTextFieldEdit(
            text: user?['bio'],
            sectionName: 'bio',
            onPressed: () => editField(context, 'bio'),
          ),
          //userpost
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text("Posts",
                style: TextStyle(color: Color.fromARGB(255, 215, 215, 215))),
          ),
        ],
      ),
    );
  }

  Widget buildPostList(List<QueryDocumentSnapshot> posts) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        String message = post['PostMessage'];
        String userEmail = post['UserEmail'];
        return MyUsersList(
          title: message,
          subtitle: userEmail,
        );
      },
    );
  }
}
