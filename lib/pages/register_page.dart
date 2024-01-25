import 'package:flutter/material.dart';
import 'package:groupchat/components/my_button.dart';
import 'package:groupchat/components/my_textfield.dart';
import '../controller/comman.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  void registerPage() {
    register(context, emailController, passwordController,
        conformPasswordController, userController);
  }

  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController conformPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(
              Icons.person,
              size: 80,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              "C H A T   A P P",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 50,
            ),
            MyTextfield(
                hintText: "User Name",
                obscureText: false,
                controller: userController),
            const SizedBox(
              height: 10,
            ),
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
            MyTextfield(
                hintText: "Conform Password",
                obscureText: true,
                controller: conformPasswordController),
            const SizedBox(
              height: 10,
            ),
            MyButton(
              text: "Register",
              onTap: registerPage,
            ),
            const SizedBox(
              height: 25,
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
