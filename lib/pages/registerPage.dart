import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../components/authTextField.dart';
import '../services/auth/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({
    super.key,
    required this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUp() async {
    if(passwordController.text != confirmPasswordController.text){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Password do not match")));
      return;
    }
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signUpWithEmailAndPassword(emailController.text, passwordController.text);
    } catch (e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
  void signInWithGoogle() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signInWithGoogleProvider();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/main.png',
                    height: 400,
                    width: 400,
                  ),
                  const SizedBox(height: 8.0),
                  Text("Green Heaven", style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600, color: HexColor("#38C1CE"))),
                  const SizedBox(height: 25),
                  AuthTextField(controller: emailController, hintText: 'Email', obscureText: false),
                  const SizedBox(height: 25),
                  AuthTextField(controller: passwordController, hintText: 'Password', obscureText: true),
                  const SizedBox(height: 25),
                  AuthTextField(controller: confirmPasswordController, hintText: 'Confirm Password', obscureText: true),
                  const SizedBox(height: 25),
                  SignInButton(
                      padding: EdgeInsets.symmetric(vertical: 23, horizontal: 15),
                      mini: false,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
                      Buttons.Email,onPressed: signUp, text: "Sign Up with Email"),
                  // const SizedBox(height: 10),
                  // SignInButton(
                  //     padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  //     mini: false,
                  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
                  //     Buttons.Google,onPressed: signInWithGoogle, text: "Continue with Google"),
                  const SizedBox(height: 25),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already a Member?"),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text("Login Now", style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}