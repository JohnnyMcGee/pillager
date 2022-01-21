import 'package:flutter/material.dart';
import 'package:pillager/models/models.dart';
import 'package:pillager/services/services.dart';

List<Comment> comments = [
  Comment(
      sender: "0tsNz6KtFtP6virwrie3IW1eOjg2",
      timeStamp: DateTime(2022, 1, 21, 14),
      message: "Let us defeat our enemies!"),
  Comment(
      sender: "jJqRNN5En7Yqs8fGPzxKaAkZqpd2",
      timeStamp: DateTime(2022, 1, 21, 14, 5),
      message: "We will send them up to the Gods"),
  Comment(
      sender: "",
      timeStamp: DateTime(2022, 1, 21, 14, 6),
      message: "Ragnar updated the location: Northumbria"),
];

class Message extends StatelessWidget {
  final Comment comment;
  final bool received;
  const Message({Key? key, required this.comment, required this.received})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Align(
        alignment: received ? Alignment.topLeft : Alignment.topRight,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: received ? Colors.grey : Colors.blue,
          ),
          padding: const EdgeInsets.all(16),
          child: Text(
            comment.message,
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ),
    );
  }
}

class RaidChat extends StatefulWidget {
  final Raid raid;
  const RaidChat({Key? key, required this.raid}) : super(key: key);

  @override
  _RaidChatState createState() => _RaidChatState();
}

class _RaidChatState extends State<RaidChat> {
  @override
  Widget build(BuildContext context) {
    final String uid = AuthService().currentUser!.uid;

    return Stack(
      children: [
        ListView.builder(
          itemCount: comments.length,
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 10),
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final Comment comment = comments[index];

            if (comment.sender.isEmpty) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    comment.message,
                    style: const TextStyle(color: Colors.black54),
                  ),
                ),
              );
            }

            return Message(
              comment: comment,
              received: uid != comment.sender,
            );
          },
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
            height: 50,
            width: double.infinity,
            color: Colors.white,
            child: Row(
              children: <Widget>[
                const SizedBox(
                  width: 15,
                ),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: "Write a comment...",
                        hintStyle: TextStyle(color: Colors.black54),
                        border: InputBorder.none),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                FloatingActionButton(
                  onPressed: () {},
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
