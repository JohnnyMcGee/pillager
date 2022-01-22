import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pillager/screens/screens.dart';
import 'package:pillager/bloc/bloc.dart';

class PillagerApp extends StatelessWidget {
  const PillagerApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    context.read<SignInBloc>().add(SignInEmailButtonPressed(email: "ragnar@vikings.vik", password: "sailwest"));
    
    return MaterialApp(
        title: 'Pillager - Management Solutions for the Modern Viking',
        home: BlocBuilder<SignInBloc, SignInState>(
            builder: (BuildContext context, state) {
          return (state is LoggedIn)
              ? const Home()
              : const Authentication();
        }));
  }
}
