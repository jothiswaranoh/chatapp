import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper {
  static Future<String?> getUserNameByEmail(String userEmail) async {
    try {
      var querySnapshot = await FirebaseFirestore.instance
          .collection("users") // Replace with your actual collection name
          .where("email", isEqualTo: userEmail)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var userName = querySnapshot.docs.first.get("username");
        print(userName);
        return userName.toString();
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching user: $e");
      return null;
    }
  }
}
