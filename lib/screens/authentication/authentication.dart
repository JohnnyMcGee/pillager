import 'package:flutter/material.dart';
import 'package:pillager/widgets/widgets.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {

  bool showSignIn = true;

  void toggleSignInForm() {
    setState(() {showSignIn = !showSignIn;});
  }
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Text('Pillager'),
        elevation: 0.0,
      ),
      body: showSignIn? SignIn(toggleSignInForm: toggleSignInForm) : Register(toggleSignInForm: toggleSignInForm),
    );
  }
}
