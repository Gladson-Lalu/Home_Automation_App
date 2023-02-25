import 'package:flutter/material.dart';

import 'text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: Theme.of(context).primaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: Theme.of(context).primaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
