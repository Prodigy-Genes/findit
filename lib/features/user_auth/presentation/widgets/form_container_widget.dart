//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FormContainerWidget extends StatefulWidget {
  final TextEditingController? controller;
  final Key? fieldKey;
  final bool? isPasswordField;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType? inputType;

  const FormContainerWidget({
    super.key,
    this.controller,
    this.fieldKey,
    this.isPasswordField,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    this.inputType,
  });

  @override
  State<FormContainerWidget> createState() => _FormContainerWidgetState();
}

class _FormContainerWidgetState extends State<FormContainerWidget> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 225, 225, 225).withOpacity(0.10), // Adjust opacity for transparency
        borderRadius: BorderRadius.circular(20.0), // Set border radius for curve
      ),
      child: TextFormField(
        style: const TextStyle(color: Colors.blue),
        controller: widget.controller,
        keyboardType: widget.inputType,
        key: widget.fieldKey,
        obscureText: widget.isPasswordField == true ? _obscureText : false,
        onSaved: widget.onSaved,
        validator: (value) {
          if (widget.hintText?.toLowerCase() == "email") {
            if (value == null || value.isEmpty) {
              return "Please enter your email.";
            } else if (!RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(value)) {
              return "Please enter a valid email address.";
            }
          } else if (widget.isPasswordField == true) {
            if (value == null || value.isEmpty) {
              return "Please enter your password.";
            }
          }
          return null; // No error message
        },
        onFieldSubmitted: widget.onFieldSubmitted,
        decoration: InputDecoration(
          border: InputBorder.none, // Remove default border
          filled: true,
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Colors.black45),
          prefixIcon: widget.isPasswordField == false
              ? const Icon(Icons.email_outlined, color: Colors.grey, size: 16,) // Username icon
              : (widget.hintText?.toLowerCase() == "email") // Check for "Email" hint
                ? const Icon(Icons.email, color: Colors.grey, size: 16,) // Email icon
                : const Icon(Icons.lock_outlined, color: Colors.grey, size: 16,), // No icon for password
          suffixIcon: widget.isPasswordField == true
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility, size: 16,
                    color: _obscureText == false ? Colors.blue : Colors.grey,
                  ),
                )
              : null, // Add password visibility toggle for password fields
        ),
      ),
    );
  }
}
