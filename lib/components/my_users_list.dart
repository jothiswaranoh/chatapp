// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';

class MyUsersList extends StatefulWidget {
  final String title;
  final String subtitle;

  const MyUsersList({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  _MyUsersListState createState() => _MyUsersListState();
}

class _MyUsersListState extends State<MyUsersList> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      child: Container(
        decoration: BoxDecoration(
          color: theme.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          title: _buildUserName(),
          subtitle: _buildUserEmail(),
        ),
      ),
    );
  }

  Widget _buildUserName() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:
     widget.title != null
          ? Text(widget.title)
          : const CircularProgressIndicator(),
    );
  }

  Widget _buildUserEmail() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
