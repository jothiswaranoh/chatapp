// ignore_for_file: prefer_const_constructors

import 'package:groupchat/auth/auth.dart';
import 'package:groupchat/auth/login_or_register.dart';
import 'package:groupchat/firebase_options.dart';
import 'package:groupchat/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:groupchat/pages/profile_page.dart';
import 'package:groupchat/pages/users_page.dart';
import 'package:groupchat/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthPage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
      debugShowCheckedModeBanner: false,
      routes: {
        '/login_register_page': (context) => const LoginOrRegister(),
        '/home_page': (context) => HomePage(),
        '/profile_page': (context) => ProfilePage(),
        '/users_page': (context) => UsersPage(),
      },
    );
  }
}
