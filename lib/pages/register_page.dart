import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../util/my_button.dart';
import '../util/my_text_field.dart';

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
  // register controller
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final retypePasswordController = TextEditingController();

  // register user button
  void registerUser() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // try user in
    try {
      if (passwordController.text == retypePasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: usernameController.text,
          password: passwordController.text,
        );
      } else {
        showErrorMessage('Passwords dont match');
      }
      // pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);
      //WRONG EMAIL
      showErrorMessage(e.code);
    }
  }

  // wrong email message pop up
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(top: 165.0),
          child: AlertDialog(
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            shadowColor: Colors.transparent,
            title: Center(
              child: Text(
                message,
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 212, 28, 14),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.only(top: 160.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  children: [
                    // logo
                    const Icon(
                      Icons.lock,
                      size: 150,
                    ),

                    // title
                    Text(
                      'User Register',
                      style: GoogleFonts.outfit(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // email text field
                    MyTextField(
                      controller: usernameController,
                      text: 'Enter Email',
                      obscureText: false,
                    ),

                    // password text field
                    MyTextField(
                      controller: passwordController,
                      text: 'Enter Password',
                      obscureText: true,
                    ),

                    // password text field
                    MyTextField(
                      controller: retypePasswordController,
                      text: 'Re-Enter Password',
                      obscureText: true,
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // register button
                MyButton(
                  onTap: registerUser,
                  text: 'Register',
                ),

                // not a member? Register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already a member?',
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Login',
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
