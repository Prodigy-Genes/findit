// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print, prefer_final_fields, unused_local_variable

import 'package:findit/features/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:findit/features/user_auth/presentation/pages/home_page.dart';
import 'package:findit/features/user_auth/presentation/pages/login_page.dart';
import 'package:findit/features/user_auth/presentation/widgets/form_container_widget.dart';
import 'package:findit/features/user_auth/presentation/widgets/username_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupPage extends StatefulWidget {
  final String username;
  //final String _password;
  //final String _confirmPassword;

  const SignupPage({super.key, required this.username});
  //: _password = "",
  //  _confirmPassword = "";

  @override
  State<SignupPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignupPage> {
  final FirebaseAuthServices _auth = FirebaseAuthServices();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  TextEditingController _confirmpasswordcontroller = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _confirmpasswordcontroller.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  //String _username = "";
  //final String _password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Welcome To Findit",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                UsernameWidget(
                  username: widget.username,
                  controller: _usernameController,
                ),
                const SizedBox(height: 20.0),
                FormContainerWidget(
                  controller: _emailcontroller,
                  hintText: "Email",
                  isPasswordField: false,
                ),
                const SizedBox(height: 10.0),
                FormContainerWidget(
                  controller: _passwordcontroller,
                  hintText: "Password",
                  isPasswordField: true,
                ),
                const SizedBox(height: 10.0),
                FormContainerWidget(
                  controller: _confirmpasswordcontroller,
                  hintText: "Confirm Password",
                  isPasswordField: true,
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Check if passwords match before signup logic
                      if (_passwordcontroller.text ==
                          _confirmpasswordcontroller.text) {
                        // Handle signup logic here (e.g., call API)
                        _signup();
                      } else {
                        // Show error message: "Passwords do not match"
                      }
                    }
                  },
                  child: const Text('Signup'),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    TextButton(
                      onPressed: () {
                        // Handle navigation to login page
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                            (route) => false);
                      },
                      child: const Text('Login'),
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

  void _signup() async {
  String email = _emailcontroller.text;
  String password = _passwordcontroller.text;

  try {
    User? user = await _auth.signUpWithEmailAndPassword(email, password);
    // User signup successful
    print("Signup successful for user: ");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        (route) => false);
  } on FirebaseAuthException catch (e) {
    // Handle specific Firebase Authentication errors
    String errorMessage;
    switch (e.code) {
      case 'weak-password':
        errorMessage = 'The password is too weak.';
        break;
      case 'email-already-in-use':
        errorMessage = 'The email address is already in use by another account.';
        break;
      case 'invalid-email':
        errorMessage = 'The email address is invalid.';
        break;
      default:
        errorMessage = 'An error occurred. Please try again later.';
    }
    print(errorMessage); // Log the error message for debugging
    // Display user-friendly error message using a snackbar or other UI element
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        backgroundColor: Colors.red,
      ),
    );
  } catch (e) {
    // Handle other exceptions
    print("An unexpected error occurred: $e");
    // Display a generic error message to the user
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('An unexpected error occurred. Please try again later.'),
        backgroundColor: Colors.red,
      ),
    );
  }
}

}
