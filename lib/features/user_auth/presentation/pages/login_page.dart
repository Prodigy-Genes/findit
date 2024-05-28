// ignore_for_file: unused_catch_clause, prefer_final_fields, use_build_context_synchronously, avoid_print

import 'package:findit/features/user_auth/presentation/pages/home_page.dart';
import 'package:findit/features/user_auth/presentation/pages/signup_page.dart';
import 'package:findit/features/user_auth/presentation/widgets/form_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:findit/features/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final FirebaseAuthServices _auth = FirebaseAuthServices();

  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  final String _username = "";
  //String _password = "";

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
                  "Welcome Back",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Handle login logic here (e.g., call API)
                      _signin();
                    }
                  },
                  child: const Text('Login'),
                ),
                const SizedBox(height: 10.0),
                TextButton(
                  onPressed: () {
                    // Handle "Forgot Password" functionality
                  },
                  child: const Text('Forgot Password?'),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account?'),
                    TextButton(
                      onPressed: () {
                        // Handle navigation to signup page
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SignupPage(username: _username)),
                            (route) => false);
                      },
                      child: const Text('Sign Up'),
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
  void _signin() async {
  String email = _emailcontroller.text;
  String password = _passwordcontroller.text;

  try {
    User? user = await _auth.signInWithEmailAndPassword(email, password);
    // Check if user is not null (sign-in successful)
    if (user != null) {
      print("Signin successful for user: ${user.email}");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
          (route) => false);
    } else {
      // Sign-in failed, handle error (likely a Firebase Auth exception)
      // ... (your existing error handling code here)
    }
  } on FirebaseAuthException catch (e) {
    // Handle specific Firebase Authentication errors (your existing code)
  } catch (e) {
    // Handle other exceptions (your existing code)
  }
}

}
