import 'package:flutter/material.dart';

import 'package:pillager/shared.dart';

class PasswordFormField extends StatefulWidget {
  final String initialValue;
  final String hintText;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;

  const PasswordFormField({
    Key? key,
    this.initialValue='',
    this.hintText = '',
    this.onChanged,
    this.onFieldSubmitted,
  }) : super(key: key);

  @override
  _PasswortFormFieldState createState() => _PasswortFormFieldState();
}

class _PasswortFormFieldState extends State<PasswordFormField> {
  bool _visible = false;

  void viewPassword() => setState(() {
        _visible = !_visible;
      });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialValue,
      onChanged: widget.onChanged ?? (_) {},
      obscureText: !_visible,
      decoration: fieldDecoration.copyWith(
        hintText: widget.hintText,
        suffix: IconButton(
          icon: Icon(_visible
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined),
          onPressed: viewPassword,
        ),
      ),
      onFieldSubmitted: widget.onFieldSubmitted,
    );
  }
}
