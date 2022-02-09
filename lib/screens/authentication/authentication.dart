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
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
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
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (Widget child, Animation<double> animation) {
          final x0 = showSignIn ? -1.0 : 1.0;
          final inAnimation =
              Tween(begin: Offset(x0, 0), end: const Offset(0, 0))
                  .animate(animation);
          final outAnimation =
              Tween(begin: Offset(-x0, 0), end: const Offset(0, 0))
                  .animate(animation);
          return SlideTransition(
              child: child,
              position: (child.key == Key(showSignIn.toString()))
                  ? inAnimation
                  : outAnimation);
        },
        child: SafeArea(
          key: Key(showSignIn.toString()),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        fit: FlexFit.loose,
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 550),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 20),
                          child: showSignIn
                              ? SignIn(toggleSignInForm: toggleSignInForm)
                              : Register(toggleSignInForm: toggleSignInForm),
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
    );
  }
}
