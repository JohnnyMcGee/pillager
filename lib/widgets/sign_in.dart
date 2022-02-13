import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pillager/bloc/bloc.dart';

import 'package:pillager/shared.dart';
import 'package:pillager/widgets/widgets.dart';

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

  void _submitForm() {
    context
        .read<SignInBloc>()
        .add(SignInEmailButtonPressed(email: email, password: password));
  }

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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: TextFormField(
              onChanged: (value) => setState(() {
                email = value;
              }),
              decoration: fieldDecoration.copyWith(hintText: "email"),
              onFieldSubmitted: (_) => _submitForm(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: PasswordFormField(
              onChanged: (value) => setState(() {
                password = value;
              }),
              hintText: "password",
              onFieldSubmitted: (_) => _submitForm(),
            ),
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
              onPressed: _submitForm,
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Don't have an account yet? ",
                  style: Theme.of(context).textTheme.bodyText2,
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
