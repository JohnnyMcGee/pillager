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
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Flexible(
                        flex: 2,
                        child: SizedBox(),
                      ),
                      Flexible(
                        flex: 5,
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 450),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: TextFormField(
                                    initialValue: '',
                                    onChanged: (val) {
                                      setState(() => email = val);
                                    },
                                    decoration: const InputDecoration(
                                        hintText: "email",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30.0)),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 16)),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: TextFormField(
                                    initialValue: '',
                                    onChanged: (val) {
                                      setState(() => password = val);
                                    },
                                    decoration: const InputDecoration(
                                      hintText: "password",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30.0)),
                                      ),
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 30, bottom: 20),
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
                                              email: email,
                                              password: password));
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Flexible(
                        flex: 2,
                        child: SizedBox(),
                      ),
                    ],
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
            ),
          ),
        ],
      ),
    );
  }
}
