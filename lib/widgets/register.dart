import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pillager/services/services.dart';

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
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: size.height * 0.05),
          child: Align(
            child: Text(
              'Create an Account',
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
                  setState(() => firstName = val);
                },
                decoration: InputDecoration(hintText: "first name"),
              ),
              SizedBox(height: size.height * .05),
              TextFormField(
                initialValue: '',
                onChanged: (val) {
                  setState(() => lastName = val);
                },
                decoration: InputDecoration(hintText: "last name"),
              ),
              SizedBox(height: size.height * .05),
              TextFormField(
                initialValue: '',
                onChanged: (val) {
                  setState(() => email = val);
                },
                decoration: InputDecoration(hintText: "email"),
              ),
              SizedBox(height: size.height * .05),
              TextFormField(
                initialValue: '',
                onChanged: (val) {
                  setState(() => password = val);
                },
                decoration: InputDecoration(hintText: "password"),
              ),
              SizedBox(height: size.height * .05),
              TextFormField(
                initialValue: '',
                onChanged: (val) {
                  setState(() => confirmPassword = val);
                },
                decoration: InputDecoration(hintText: "confirm password"),
              ),
              SizedBox(height: size.height * .1),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color?>(Colors.blueGrey[400]),
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  _auth.registerWithEmailAndPassword(email, password);
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
                text: "Already have an account? ",
                style: TextStyle(
                  color: Colors.blueGrey[900],
                  fontSize: size.height * 0.018,
                ),
              ),
              WidgetSpan(
                child: InkWell(
                  onTap: () => widget.toggleSignInForm(),
                  child: Text(
                    "Login",
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
    );
  }
}
