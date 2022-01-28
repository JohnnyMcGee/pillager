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
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: size.height * 0.05),
                    child: const Text(
                      'Welcome Back',
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: '',
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                        decoration: const InputDecoration(hintText: "email"),
                      ),
                      SizedBox(height: size.height * .05),
                      TextFormField(
                        initialValue: '',
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                        decoration: const InputDecoration(hintText: "password"),
                      ),
                      SizedBox(height: size.height * .1),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color?>(Colors.blueGrey[400]),
                        ),
                        child: const Text(
                          'Sign in',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          context.read<SignInBloc>().add(SignInEmailButtonPressed(
                              email: email, password: password));
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * .025),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Don't have an account yet? ",
                        style: TextStyle(
                          color: Colors.blueGrey[900],
                          fontSize: size.height * 0.018,
                        ),
                      ),
                      WidgetSpan(
                        child: InkWell(
                          onTap: () => widget.toggleSignInForm(),
                          child: Text(
                            "Register",
                            style: TextStyle(
                              color: Colors.blueGrey[400],
                              fontSize: size.height * 0.018,
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
        ],
      ),
    );
  }
}
