import 'package:flutter/material.dart';
import 'package:whisper/services/auth/auth_service.dart';
import 'package:whisper/components/my_button.dart';
import 'package:whisper/components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  //email and pw text controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _ConfirmPwController = TextEditingController();

  //tap to go to register page
  final void Function()? onTap;

  RegisterPage({super.key, this.onTap});

  //register method
  void register(BuildContext context) {
    //get auth service
    final _auth = AuthService();
    //passwords match --> create user
    if (_pwController.text == _ConfirmPwController.text) {
      try {
        _auth.signUpWithEmailPassword(
          _emailController.text,
          _pwController.text,
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    }
    //paswords don't match --> tell user to fix

    else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text(
            "Passwords don't match!",
            style: TextStyle(fontFamily: 'SFPro'),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Image.asset(
              'images/icon.png', // Replace with the path to your image
              height: 100.0, // Adjust as needed
              width: 100.0, // Adjust as needed
            ),

            const SizedBox(height: 50),

            //welcome back message
            Text(
              "Let's create an account for you!",
              style: TextStyle(
                fontFamily: 'SFPro',
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 25),

            //email text field
            MyTextField(
              hintText: "Email",
              obscureText: false,
              controller: _emailController,
            ),

            const SizedBox(height: 10),

            //pw text field
            MyTextField(
              hintText: "Password",
              obscureText: true,
              controller: _pwController,
            ),

            const SizedBox(height: 10),

            //confirm pw text field
            MyTextField(
              hintText: "Confirm password",
              obscureText: true,
              controller: _ConfirmPwController,
            ),

            const SizedBox(height: 10),

            //login button
            MyButton(
              text: 'Register',
              onTap: () => register(context),
            ),

            const SizedBox(height: 25),
            //register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontFamily: 'SFPro'),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "Login now!",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontFamily: 'SFPro'),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
