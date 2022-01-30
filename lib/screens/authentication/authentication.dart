import 'package:flutter/material.dart';
import 'package:pillager/widgets/widgets.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool showSignIn = false;

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
        title: const Text(
          'Pillager',
          style: TextStyle(
            fontSize: 22,
          ),
        ),
        elevation: 0.0,
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: showSignIn
            ? SignIn(toggleSignInForm: toggleSignInForm)
            : Register(toggleSignInForm: toggleSignInForm),
      ),
    );
  }
}
