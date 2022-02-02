import 'package:flutter/material.dart';

Widget buildTextFormField({
  required void Function(String) onChanged,
  String initialValue = '',
  String hintText = '',
  double verticalPadding = 10,
  bool obscureText = false,
  void Function()? viewPassword,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: verticalPadding),
    child: TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        suffix: (viewPassword != null)
            ? IconButton(
                icon: Icon(obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                onPressed: viewPassword,
              )
            : null,
      ),
    ),
  );
}
