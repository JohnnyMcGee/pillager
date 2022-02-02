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
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: ListView(
                  children: [
                    RaidForm(raidId: raidId),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  child: RaidChat(raidId: raidId),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
