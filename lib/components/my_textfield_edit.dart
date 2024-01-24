import 'package:flutter/material.dart';

class MyTextFieldEdit extends StatelessWidget {
  MyTextFieldEdit(
      {super.key,
      required this.text,
      required this.sectionName,
      required this.onPressed});
  final String text;
  final String sectionName;
  void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.only(left: 15, bottom: 15),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                sectionName,
                style: TextStyle(color: Colors.grey[500]),
              ),
              IconButton(
                  onPressed: onPressed,
                  icon: Icon(
                    Icons.settings,
                    color: Colors.grey[400],
                  ))
            ],
          ),
// text
          Text(text, style: const TextStyle(color: Colors.black)),
        ],
      ),
    );
  }
}
