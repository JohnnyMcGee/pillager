import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pillager/bloc/bloc.dart';
import 'package:pillager/shared.dart';
import 'package:pillager/widgets/widgets.dart';

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

  void _submitForm() {
    context.read<SignInBloc>().add(RegisterEmailButtonPressed(
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
          confirmPassword: confirmPassword,
        ));
  }

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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: TextFormField(
              onChanged: (val) => setState(() => firstName = val),
              onFieldSubmitted: (_) => _submitForm(),
              decoration: fieldDecoration.copyWith(hintText: "first name"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: TextFormField(
              onChanged: (val) => setState(() => lastName = val),
              onFieldSubmitted: (_) => _submitForm(),
              decoration: fieldDecoration.copyWith(hintText: "last name"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: TextFormField(
              onChanged: (val) => setState(() => email = val),
              onFieldSubmitted: (_) => _submitForm(),
              decoration: fieldDecoration.copyWith(hintText: "email"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: PasswordFormField(
              onChanged: (val) => setState(() => password = val),
              hintText: "password",
              onFieldSubmitted: (_) => _submitForm(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: PasswordFormField(
              onChanged: (val) => setState(() => confirmPassword = val),
              hintText: "confirm password",
              onFieldSubmitted: (_) => _submitForm(),
            ),
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
              onPressed: _submitForm,
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Already have an account? ",
                  style: Theme.of(context).textTheme.bodyText2,
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
