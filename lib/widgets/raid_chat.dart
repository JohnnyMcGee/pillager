import 'package:flutter/material.dart';
import 'package:pillager/models/models.dart';

class RaidChat extends StatefulWidget {
  final Raid raid;
  const RaidChat({Key? key, required this.raid}) : super(key: key);

  @override
  _RaidChatState createState() => _RaidChatState();
}

class _RaidChatState extends State<RaidChat> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
              height: 50,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  const SizedBox(width: 15,),
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Write a comment...",
                        hintStyle: TextStyle(color: Colors.black54),
                        border: InputBorder.none
                      ),
                    ),
                  ),
                  const SizedBox(width: 15,),
                  FloatingActionButton(
                    onPressed: (){},
                    child: const Icon(Icons.send),
                    backgroundColor: Colors.blueGrey[900],
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
