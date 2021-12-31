import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email = '';
  String password = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: size.height * 0.05),
          child: Align(
            child: Text(
              'Welcome Back',
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: size.height * 0.025,
              ),
            ),
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
              ),
              SizedBox(height: size.height * .05),
              TextFormField(
                initialValue: '',
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: size.height * .1),
              ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color?>(
                            Colors.blueGrey[400]),
                      ),
                      child: Text(
                        'Sign in',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        print("$email, $password");
                      },
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
