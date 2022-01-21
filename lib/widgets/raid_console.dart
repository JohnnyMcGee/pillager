import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pillager/bloc/bloc.dart';

class RaidConsole extends StatelessWidget {
  String raidId;

  RaidConsole({Key? key, required this.raidId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RaidBloc, RaidState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(100.0),
          child: Text("Raid Console"),
        );
      },
    );
  }
}
