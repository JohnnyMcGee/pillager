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
      child: (size.width > 850)
          ? Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        right: BorderSide(width: 1.0, color: Colors.black38),
                      ),
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        RaidForm(raidId: raidId),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: RaidChat(raidId: raidId),
                ),
              ],
            )
          : ListView(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1.0, color: Colors.black38),
                    ),
                  ),
                  child: RaidForm(raidId: raidId),
                ),
                Container(
                    constraints: BoxConstraints(maxHeight: 800),
                    child: RaidChat(
                      raidId: raidId,
                    ))
              ],
            ),
    );
  }
}
