
//display error to the user
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:groupchat/helper/firebase_helper.dart';


void DisplayMessageToUser(String message,BuildContext context){

  showDialog(context: context,
   builder: (context) =>AlertDialog(
    title: Text(message),
   )
   );

}

String formatData(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();
  String year = dateTime.year.toString();
  String month = dateTime.month.toString().padLeft(2, '0'); // Pad with zero if needed
  String day = dateTime.day.toString().padLeft(2, '0'); // Pad with zero if needed

  return '$day/$month/$year'; // Adjust the format as needed
}


// void emailtouser(String email) async{
//     String? userName = await FirestoreHelper.getUserNameByEmail(email);
//     print("User Name: $userName");
//     return userName;

// }
