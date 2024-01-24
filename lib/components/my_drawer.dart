// ignore_for_file: prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:groupchat/theme/dark_mode.dart';
import '../variables/app_colors.dart';
import '../theme/theme_provider.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  void logout() {
    FirebaseAuth.instance.signOut();
  }

  void onTap(BuildContext context) {
    Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
  }

  @override
  Widget build(BuildContext context) => Drawer(
    backgroundColor: AppColors.appTextColor,
    shadowColor: AppColors.blackColor,
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            buildMenuItems(context),
          ],
        ),
      ));
}

Widget buildHeader(BuildContext context) => Container(
      color: AppColors.appBarColor,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      child: const Column(children: [
        SizedBox(height: 10),
        Image(image: AssetImage("../assets/logo.png"),width: 100,height: 100,fit: BoxFit.cover,),
        SizedBox(height: 12),
        Text(
          'CHATTING APP',
          style: TextStyle(fontSize: 28, color: AppColors.appTextColor,fontWeight: FontWeight.bold,),
        ),
        SizedBox(height: 12),
      ]),
    );

Widget buildMenuItems(BuildContext context) => Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Wrap(
            runSpacing: 16,
            children: [
              buildListTile(Icons.home, "H O M E", "", context),
              buildListTile(
                  Icons.person, "P R O F I L E", "/profile_page", context),
              buildListTile(Icons.group, "U S E R S", "/users_page", context),
              SizedBox(height: MediaQuery.of(context).size.height / 2.2),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  buildListTile(
                      Icons.logout_outlined, "L O G O U T", "", context),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Switch(
                      value: Provider.of<ThemeProvider>(context).themeData ==
                          darktMode,
                      onChanged: (value) {
                        Provider.of<ThemeProvider>(context, listen: false)
                            .toggleTheme();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );

ListTile buildListTile(
    IconData icon, String title, String route, BuildContext context) {
  return ListTile(
    leading: Icon(icon),
    title: Text(title),
    onTap: () {
      Navigator.pop(context);
      if (route.isNotEmpty) {
        Navigator.pushNamed(context, route);
      } else {
        FirebaseAuth.instance.signOut();
      }
    },
  );
}
