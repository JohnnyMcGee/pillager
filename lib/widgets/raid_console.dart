import 'package:flutter/material.dart';

import 'package:pillager/widgets/widgets.dart';

class RaidConsole extends StatelessWidget {
  final String raidId;

  const RaidConsole({Key? key, required this.raidId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * .8,
      padding: const EdgeInsets.all(20.0),
      child: (size.width > 700)
          ? Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: ListView(
                    children: [
                      RaidForm(raidId: raidId),
                    ],
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    child: RaidChat(raidId: raidId),
                  ),
                ),
              ],
            )
          : ListView(
              children: [
                RaidForm(raidId: raidId),
                Container(
                    padding: const EdgeInsets.all(10.0),
                    constraints: BoxConstraints(maxHeight: 800),
                    child: RaidChat(
                      raidId: raidId,
                    ))
              ],
            ),
    );
  }
}
