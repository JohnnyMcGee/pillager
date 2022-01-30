import 'package:flutter/material.dart';

Widget buildTextFormField({
  required void Function(String) onChanged,
  String initialValue = '',
  String hintText = '',
  double verticalPadding = 10,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: verticalPadding),
    child: TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16)),
    ),
  );
}
