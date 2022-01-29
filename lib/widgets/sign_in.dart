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
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: size.height * 0.05),
                      child: const Text(
                        'Welcome Back',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold  ,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height:size.height*.06),
                    SizedBox(
                      width: size.width * .67,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
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
                            SizedBox(height: size.height * .06),
                            TextFormField(
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
                            SizedBox(height: size.height * .1),
                            ElevatedButton(
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
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: size.height * .033),
                      child: RichText(
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
                                child: const Text(
                                  "Register",
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
