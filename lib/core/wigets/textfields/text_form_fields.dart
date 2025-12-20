import 'package:flutter/material.dart';

class TextFormFields {
  static Widget txtNumber(
    String placeholder,
    Icon myIcon,
    TextEditingController textController,
  ) {
    return TextFormField(
      controller: textController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: placeholder,
        filled: true,
        fillColor: Colors.white,
        prefixIcon: myIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.blue.shade700, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.blue.shade700, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.blue.shade700, width: 2.5),
        ),
      ),
    );
  }

  static Widget txtPassword(
    String placeholder,
    Icon myIcon,
    TextEditingController textController,
    bool showPass,
    VoidCallback onTap,
  ) {
    return TextFormField(
      controller: textController,
      keyboardType: TextInputType.number,
      obscureText: showPass,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            onTap();
          },
          icon:
              showPass
                  ? Icon(Icons.visibility_off, color: Colors.blue.shade700)
                  : Icon(Icons.visibility, color: Colors.blue.shade700),
        ),
        hintText: placeholder,
        filled: true,
        fillColor: Colors.white,
        prefixIcon: myIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.blue.shade700, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.blue.shade700, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.blue.shade700, width: 2.5),
        ),
      ),
    );
  }
}
