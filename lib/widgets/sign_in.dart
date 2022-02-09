import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pillager/bloc/bloc.dart';

import 'package:pillager/shared.dart';

class SignIn extends StatefulWidget {
  final Function toggleSignInForm;

  const SignIn({Key? key, required this.toggleSignInForm}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email = '';
  String password = '';
  final _formKey = GlobalKey<FormState>(debugLabel: "signInFormKey");
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40, bottom: 30),
            child: Text(
              'Welcome back!',
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.center,
            ),
          ),
          buildTextFormField(
            onChanged: (val) => setState(() {
              email = val;
            }),
            hintText: "email",
          ),
          buildTextFormField(
              onChanged: (value) => setState(() => password = value),
              hintText: "password",
              obscureText: !_passwordVisible,
              viewPassword: () => setState(() {
                    _passwordVisible = !_passwordVisible;
                  })),
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
                  text: "Don't have an account yet? ",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                WidgetSpan(
                  child: InkWell(
                    onTap: () => widget.toggleSignInForm(),
                    child: Text(
                      "Register",
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
