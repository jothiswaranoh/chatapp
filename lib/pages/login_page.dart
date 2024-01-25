import 'package:flutter/material.dart';
import 'package:groupchat/components/my_button.dart';
import 'package:groupchat/components/my_textfield.dart';
import 'package:groupchat/controller/comman.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void loginPage() {
    login(context, emailController, passwordController);
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
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                  "C H A T  A P P",
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
                const SizedBox(
                  height: 10,
                ),
                MyTextfield(
                    hintText: "Password",
                    obscureText: true,
                    controller: passwordController),

                const SizedBox(
                  height: 10,
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
                const SizedBox(
                  height: 25,
                ),

                MyButton(
                  text: "Login",
                  onTap: loginPage,
                ),
                const SizedBox(
                  height: 25,
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
