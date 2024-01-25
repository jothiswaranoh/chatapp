import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/message.dart';
import '../../controller/comman.dart';

class ChatService{
  //get instance of firestore
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //get user stream
Stream<List<Map<String,dynamic>>> getUsersStream() {
  return _firestore.collection("Users").snapshots().map((snapshot){
    return snapshot.docs.map((doc){
      //go through each individual user
      final user = doc.data();
      return user;
    }).toList();
  }
  );
}
Future<String> createGroup(String groupname,List<String> memberUserIDs) async {
    final currentUser = getCurrentUser();
    assert(currentUser != null, "getCurrentUser() should not be null");

    final String currentUserId = currentUser!.uid;
    memberUserIDs.add(currentUserId);

    memberUserIDs.sort();
    String chatRoomID = memberUserIDs.join("_");

    // Check if the group chat already exists
    final chatRoomDoc =
        await _firestore.collection("group_chat_rooms").doc(chatRoomID).get();

    if (chatRoomDoc.exists) {
      return chatRoomID; // Group chat already exists, return the existing chat room ID
    }

    // Group chat doesn't exist, create a new chat room in the 'group_chat_rooms' collection
    await _firestore.collection("group_chat_rooms").doc(chatRoomID).set({
      'groupname':groupname,
      'memberUserIDs': memberUserIDs,
    });

    return chatRoomID;
  }

Future<void> sendMessage(String receivedId, message) async {
  final currentUser = getCurrentUser();
  assert(currentUser != null, "getCurrentUser() should not be null");

  // get current userinfo
  final String currentUserId = currentUser!.uid;
  final String currentUserEmail = currentUser.email!;
  final Timestamp timestamp = Timestamp.now();
  // Check for null values before creating the Message object
  if (currentUserId != null &&
      currentUserEmail != null &&
      receivedId != null &&
      message != null &&
      timestamp != null) {
    Message newMessage = Message(
      senderId: currentUserId,
      senderemail: currentUserEmail,
      receivedID: receivedId,
      message: message,
      timestamp: timestamp,
    );


    List<String> ids = [currentUserId, receivedId];
    ids.sort();
    String chatRoomID = ids.join("_");

    // Ensure that none of the fields in the map is null before sending to Firestore
    if (!newMessage.toMap().containsValue(null)) {
      await _firestore.collection('chat_rooms').doc(chatRoomID).collection("messages").add(newMessage.toMap());
    } else {
      print("One or more properties are null. Message not sent to Firestore.");
    }
  } else {
    print("One or more properties are null. Message not sent.");
  }
}
  //construct chat room id
  //get message
  Stream<QuerySnapshot> getMessages(String userID, otherUserID){
    List<String> ids = [userID,otherUserID];
    ids.sort();
    String chatRoomID = ids.join("_");
  return _firestore.collection("chat_rooms").doc(chatRoomID).collection("messages").orderBy("timestamp", descending: false).snapshots();
  }
}