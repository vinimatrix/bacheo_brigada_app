import 'package:bacheo_brigada/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class PasswordField extends StatefulWidget {
  const PasswordField(
      {Key? key, required this.controller, this.validator, this.hintText})
      : super(key: key);
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? hintText;
  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscureText,
      controller: widget.controller,
      keyboardType: TextInputType.text,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: brand_colors.BLUE_PRESIDENCIAL,
      ),
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: Colors.blue[200],
          ),
          onPressed: () {
            // Update the state i.e. toogle the state of passwordVisible variable
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
        filled: true,
        fillColor: Colors.grey[200],
        hintText: widget.hintText,
        hintStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w200,
            color: Colors.grey.shade800),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
      ),
      validator: widget.validator,
    );
  }
}
