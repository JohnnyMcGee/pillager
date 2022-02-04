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
      decoration: fieldDecoration.copyWith(
        hintText: hintText,
        suffix: (viewPassword != null)
            ? IconButton(
                icon: Icon(obscureText
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined),
                onPressed: viewPassword,
              )
            : null,
      ),
    ),
  );
}

const fieldDecoration = InputDecoration(
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
  ),
  contentPadding: EdgeInsets.symmetric(horizontal: 16),
);
