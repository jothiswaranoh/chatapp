import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groupchat/components/my_button.dart';
import 'package:groupchat/components/my_textfield.dart';

import '../components/space.dart';
import '../helper/display_message_to_user.dart';
import 'package:groupchat/controller/comman.dart';


class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void login_page() {
    login(context,emailController,passwordController);
  }

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context)
          .colorScheme
          .background, //it change depending on the screen colors
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
              //logo
              children: [
                Icon(
                  Icons.person,
                  size: 80,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),

                //gap
                const SizedBox(
                  height: 25,
                ),
                //app name
                const Text(
                  "S O C I A L M E D I A",
                  style: TextStyle(fontSize: 20),
                ),

                //gap
                const SizedBox(
                  height: 50,
                ),
                // email
                // we create a text field out side in the components we use here
                MyTextfield(
                    hintText: "Email",
                    obscureText: false,
                    controller: emailController),
                Space(
                  inputHeight: 10,
                ), //own methoed for space
                //password
                MyTextfield(
                    hintText: "Password",
                    obscureText: true,
                    controller: passwordController),

                //forgot password
                Space(
                  inputHeight: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forgot password",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                  ],
                ),
                //sign in button
                Space(
                  inputHeight: 25,
                ),

                MyButton(
                  text: "Login",
                  onTap: login_page,
                ),
                // dont have a account registered here
                Space(
                  inputHeight: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have a account?",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        " Register here",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ]),
        ),
      ),
    );
  }
}
