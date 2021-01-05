import 'package:flutter/material.dart';
import 'package:m2m_coin/components/text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const RoundedPasswordField({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: "Password",
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.6),
          ),
          icon: Icon(
            Icons.lock,
            color: Colors.white,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: Colors.white,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
