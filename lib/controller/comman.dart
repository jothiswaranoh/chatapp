// auth_service.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../helper/display_message_to_user.dart';
import '../model/user_list.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
Future<List<Map<String, dynamic>>> getAllUsernames() async {
  try {
    QuerySnapshot<Map<String, dynamic>> usersSnapshot =
        await FirebaseFirestore.instance.collection("Users").get();

    List<Map<String, dynamic>> userList = [];

    for (QueryDocumentSnapshot<Map<String, dynamic>> userDoc
        in usersSnapshot.docs) {
      Map<String, dynamic> userData = userDoc.data();
      String uid = userData['uid'];
      String username = userData['username'];
      userList.add({
        'uid': uid,
        'username': username,
      });
    }
    return userList;
  } catch (e) {
    print("Error getting all usernames: $e");
    return [];
  }
}

void createGroupAndSave(String groupName, List<UserList> selectedUsers) async {
  // Extract the list of user IDs from the selectedUsers list
  List<String> memberUserIDs = selectedUsers.map((user) => user.uid).toList();

  // Call the createGroup method with the groupName and memberUserIDs
  // String chatRoomID = await createGroup(groupName, memberUserIDs);
  // Optionally, you can do something with the chatRoomID if needed
}

void postMessage(TextEditingController newPostController) {
  if (newPostController.text.isNotEmpty) {
    String message = newPostController.text;
    addPostToDatabase(message);
  }
  newPostController.clear();
}

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const Center(
      child: CircularProgressIndicator(),
    ),
  );
}

void hideLoadingDialog(BuildContext context) {
  Navigator.pop(context);
}

void login(BuildContext context, TextEditingController emailController,
    TextEditingController passwordController) async {
  showLoadingDialog(context);

  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );

    hideLoadingDialog(context);
  } on FirebaseAuthException catch (e) {
    hideLoadingDialog(context);
    DisplayMessageToUser(e.code, context);
  }
}

User? getCurrentUser() {
  return FirebaseAuth.instance.currentUser;
}

Future<DocumentSnapshot<Map<String, dynamic>>> getuserdetails(
    User currentUser) async {
  return await FirebaseFirestore.instance
      .collection("Users")
      .doc(currentUser.email)
      .get();
}

void addPostToDatabase(String message) {
  final currentUser = getCurrentUser();
  FirebaseFirestore.instance.collection("posts").add({
    'UserEmail': currentUser?.email,
    'message': message,
    'Timestamp': Timestamp.now(),
    'Likes': [],
  });
}

// Register related methods
Future<void> register(
  BuildContext context,
  TextEditingController emailController,
  TextEditingController passwordController,
  TextEditingController confirmPasswordController,
  TextEditingController userController,
) async {
  showDialog(
    context: context,
    builder: (context) => const Center(
      child: CircularProgressIndicator(),
    ),
  );

  if (passwordController.text != confirmPasswordController.text) {
    Navigator.pop(context);
    DisplayMessageToUser("Passwords do not match", context);
  } else {
    try {
      UserCredential? userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.pop(context);
      createUserDocument(userCredential, userController);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      DisplayMessageToUser(e.code, context);
    }
  }
}

Future<void> createUserDocument(UserCredential? userCredential,
    TextEditingController userController) async {
  if (userCredential != null && userCredential.user != null) {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(userCredential.user!.email)
        .set({
      'uid': userCredential.user!.uid,
      'email': userCredential.user!.email,
      'username': userController.text,
      'bio': 'empty',
    });
  }
}
