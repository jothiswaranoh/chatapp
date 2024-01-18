import 'dart:js_util';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseDatabase {
  User? user = FirebaseAuth.instance.currentUser;
  final CollectionReference posts =
      FirebaseFirestore.instance.collection('posts');
  Future<void> addpost(String message) {
    return posts.add({
      'UserEmail': user!.email,
      'PostMessage': message,
      'Timestamp': Timestamp.now(),
      'Likes': []
    });
  }

  Stream<QuerySnapshot> getPostsStream() {
    final PostsStream = FirebaseFirestore.instance
        .collection('posts')
        .orderBy('Timestamp', descending: true)
        .snapshots();
    return PostsStream;
  }
Stream<QuerySnapshot> getPostsStreamCurrentUser() {
  final PostsStream = FirebaseFirestore.instance
      .collection('posts')
      .where('UserEmail', isEqualTo: user!.email)
      .orderBy('Timestamp', descending: true)
      .snapshots();
  return PostsStream;
}

}
