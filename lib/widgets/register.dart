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
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 40, bottom: 30),
            child: Text(
              'Create an Account',
              style: Theme.of(context).textTheme.headline4,
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
            obscureText: !_passwordVisible,
            viewPassword: () => setState(() {
              _passwordVisible = !_passwordVisible;
            }),
          ),
          buildTextFormField(
            onChanged: (val) => setState(() => confirmPassword = val),
            hintText: "confirm password",
            obscureText: !_confirmPasswordVisible,
            viewPassword: () => setState(() {
              _confirmPasswordVisible = !_confirmPasswordVisible;
            }),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 20),
            child: ElevatedButton(
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Register',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              onPressed: () async {
                context.read<SignInBloc>().add(RegisterEmailButtonPressed(
                      firstName: firstName,
                      lastName: lastName,
                      email: email,
                      password: password,
                      confirmPassword: confirmPassword,
                    ));
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
