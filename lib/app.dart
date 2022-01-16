import 'package:flutter/material.dart';

import 'package:pillager/screens/screens.dart';

class PillagerApp extends StatelessWidget {
  const PillagerApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'Pillager - Management Solutions for the Modern Viking',
        home: Home(),
      );

  }
}