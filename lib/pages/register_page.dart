import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groupchat/components/my_button.dart';
import 'package:groupchat/components/my_textfield.dart';

import '../components/space.dart';
import '../controller/comman.dart';
import '../helper/display_message_to_user.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Future<void> register() async {
  //   //show dailog

  //   showDialog(
  //     context: context,
  //     builder: (context) => const Center(
  //       child: CircularProgressIndicator(),
  //     ),
  //   );
  //   //make sure password is match
  //   if (passwordController.text != conformpasswordController.text) {
  //     Navigator.pop(context);
  //     DisplayMessageToUser("Passwords do not match", context);
  //   }

  //   //pop loading circle
  //   else {
  //     try {
  //       // ignore: unused_local_variable
  //       UserCredential? userCredential = await FirebaseAuth.instance
  //           .createUserWithEmailAndPassword(
  //               email: emailController.text, password: passwordController.text);
  //       Navigator.pop(context);
  //       createuserdocument(userCredential);
  //     } on FirebaseAuthException catch (e) {
  //       Navigator.pop(context);
  //       DisplayMessageToUser(e.code, context);
  //     }
  //   }

  //   //try create a new
  // }
  // Future<void> register(
  // BuildContext context,
  // TextEditingController emailController,
  // TextEditingController passwordController,
  // TextEditingController confirmPasswordController,
  // TextEditingController userController,
  void register_page(){
    register(context, emailController, passwordController, conformpasswordController, userController);
  }

  TextEditingController userController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController conformpasswordController = TextEditingController();
  // Future<void> createuserdocument(UserCredential? userCredential) async {
  //   if (userCredential != null && userCredential.user != null) {
  //     await FirebaseFirestore.instance
  //         .collection("Users")
  //         .doc(userCredential.user!.email)
  //         .set({
  //       'email': userCredential.user!.email,
  //       'username': userController.text,
  //     });
  //   }
  // }

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
                //user name
                MyTextfield(
                    hintText: "User Name",
                    obscureText: false,
                    controller: userController),
                Space(
                  inputHeight: 10,
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
                MyTextfield(
                    hintText: "Conform Password",
                    obscureText: true,
                    controller: conformpasswordController),

                //forgot password
                Space(
                  inputHeight: 10,
                ),
                MyButton(
                  text: "Register",
                  onTap: register_page,
                ),
                // dont have a account registered here
                Space(
                  inputHeight: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have a account?",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        " Login here",
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
