import 'package:flutter/material.dart';
import 'package:pillager/widgets/widgets.dart';
import 'package:pillager/shared.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool showSignIn = true;

  void toggleSignInForm() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ashGray,
        title: const Text(
          'Pillager',
          style: TextStyle(
            color: navyBlue,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        elevation: 0.0,
      ),
      body: Container(
        color: ghostWhite,
        height: size.height,
        child: showSignIn
            ? SignIn(toggleSignInForm: toggleSignInForm)
            : Register(toggleSignInForm: toggleSignInForm),
      ),
    );
  }
}
