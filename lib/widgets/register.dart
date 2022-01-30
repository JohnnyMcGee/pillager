import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pillager/bloc/bloc.dart';
import 'package:pillager/shared.dart';

class Register extends StatefulWidget {
  final Function toggleSignInForm;

  const Register({Key? key, required this.toggleSignInForm}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String firstName = '';
  String lastName = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  final _formKey = GlobalKey<FormState>(debugLabel: "registerFormKey");

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 40, bottom: 30),
            child: Text(
              'Create an Account',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          buildTextFormField(
            onChanged: (val) => setState(() => firstName = val),
            hintText: "first name",
          ),
          buildTextFormField(
            onChanged: (val) => setState(() => lastName = val),
            hintText: "last name",
          ),
          buildTextFormField(
            onChanged: (val) => setState(() => email = val),
            hintText: "email",
          ),
          buildTextFormField(
            onChanged: (val) => setState(() => password = val),
            hintText: "password",
          ),
          buildTextFormField(
            onChanged: (val) => setState(() => confirmPassword = val),
            hintText: "confirm password",
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 20),
            child: ElevatedButton(
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Sign in',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              onPressed: () async {
                context.read<SignInBloc>().add(
                    SignInEmailButtonPressed(email: email, password: password));
              },
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: "Already have an account? ",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                WidgetSpan(
                  child: InkWell(
                    onTap: () => widget.toggleSignInForm(),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.secondaryVariant,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
