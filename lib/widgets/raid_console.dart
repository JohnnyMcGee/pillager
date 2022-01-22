import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pillager/bloc/bloc.dart';
import 'package:pillager/models/models.dart';
import 'package:pillager/widgets/widgets.dart';

class RaidConsole extends StatelessWidget {
  final String raidId;

  const RaidConsole({Key? key, required this.raidId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RaidBloc, RaidState>(
      builder: (context, state) {
        if (state is RaidLoaded) {
          Size size = MediaQuery.of(context).size;
          Raid raid = state.raids.firstWhere((raid) => raid.docId == raidId);

          return Container(
            height: size.height * .8,
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      color: Colors.black12,
                      child: ListView(
                        children: [
                          RaidForm(raid: raid),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      color: Colors.amber[50],
                      child: SizedBox(
                        child: RaidChat(raid: raid),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Text("Loading");
        }
      },
    );
  }
}
