import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String senderemail;
  final String receivedID;
  final String message;
  final Timestamp timestamp;

  Message({
    required this.senderId,
    required this.senderemail,
    required this.receivedID,
    required this.message,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {

    return {
      "senderId": senderId,
      "senderEmail": senderemail,
      "receiverID": receivedID,
      "message": message,
      "timestamp": timestamp, // Convert timestamp to UTC format
    };
  }
}
