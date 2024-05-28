//import 'package:flutter/foundation.dart';
// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class UsernameWidget extends StatelessWidget {
  final username;
  final TextEditingController? controller;

  const UsernameWidget(
      {super.key,required this.username, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 178, 178, 178)
            .withOpacity(0.10), // Adjust opacity for transparency
        borderRadius:
            BorderRadius.circular(20.0), // Set border radius for curve
      ),
      child: TextFormField(
        initialValue: username, // Set initial value from received parameter
        style: const TextStyle(color: Colors.blue),
        decoration: const InputDecoration(
          border: InputBorder.none, // Remove default border
          filled: true,
          hintText: "Username",
          hintStyle: TextStyle(color: Colors.black45),
          prefixIcon: Icon(Icons.person, color: Colors.grey, size: 16),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your username';
          }
          return null;
        },
        // No need for onSaved as the username is already received
      ),
    );
  }
}
