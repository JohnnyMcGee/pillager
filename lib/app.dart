import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pillager/bloc/bloc.dart';
import 'package:pillager/screens/screens.dart';
import 'themes.dart';

class PillagerApp extends StatelessWidget {
  const PillagerApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Pillager - Management Solutions for the Modern Viking',
        home: Theme(
          data: ThemeData.from(colorScheme: scheme),
          child: BlocBuilder<SignInBloc, SignInState>(
              builder: (BuildContext context, state) {
            return (state is LoggedIn) ? const Home() : const Authentication();
          }),
        ));
  }
}
