import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:pillager/bloc/bloc.dart';
import 'package:pillager/screens/screens.dart';

class AppWrapper extends StatelessWidget {
  const AppWrapper({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      builder: (context, state) {
        if (state is LoggedIn) {
          return const Home();
        } else {
          return const Authentication();
        }
      },
    );
  }
}