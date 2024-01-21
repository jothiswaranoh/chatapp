// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import '../controller/comman.dart';

class MyListTile extends StatefulWidget {
  final String title;
  final String subtitle;
  const MyListTile({super.key, required this.title, required this.subtitle});

  @override
  State<MyListTile> createState() => _MyListTileState();
}

class _MyListTileState extends State<MyListTile> {
  final currentUser=getCurrentUser();

  @override
Widget build(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 25),
    child: Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: _buildTitle(),
        subtitle: _buildSubtitle(),
      ),
    ),
  );
}

Widget _buildTitle() {
  return Padding(
    padding: const EdgeInsets.all(8.0), // Adjust padding as needed
    child: widget.title != null
        ? Text(widget.title)
        : const CircularProgressIndicator(),
  );
}

Widget _buildSubtitle() {
  return Padding(
    padding: const EdgeInsets.all(8.0), // Adjust padding as needed
    child: widget.subtitle != null
        ? Text(
            widget.subtitle,
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
            ),
          )
        : const CircularProgressIndicator(),
  );
}
}
