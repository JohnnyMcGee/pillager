import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pillager/bloc/bloc.dart';

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              fit: FlexFit.loose,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 550),
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 40, bottom: 30),
                        child: Text(
                          'Welcome back!',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          initialValue: '',
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                          decoration: const InputDecoration(
                              hintText: "email",
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 16)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          initialValue: '',
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                          decoration: const InputDecoration(
                            hintText: "password",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                            ),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16),
                          ),
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
                          onPressed: () async {
                            context.read<SignInBloc>().add(
                                SignInEmailButtonPressed(
                                    email: email, password: password));
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
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondaryVariant,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
