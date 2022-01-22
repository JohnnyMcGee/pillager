import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pillager/bloc/bloc.dart';
import 'package:pillager/models/models.dart';
import 'package:pillager/services/services.dart';

// List<Comment> comments = [
//   Comment(
//       sender: "0tsNz6KtFtP6virwrie3IW1eOjg2",
//       timeStamp: DateTime(2022, 1, 21, 14),
//       message: "Let us defeat our enemies!"),
//   Comment(
//       sender: "jJqRNN5En7Yqs8fGPzxKaAkZqpd2",
//       timeStamp: DateTime(2022, 1, 21, 14, 5),
//       message: "We will send them up to the Gods"),
//   Comment(
//       sender: "",
//       timeStamp: DateTime(2022, 1, 21, 14, 6),
//       message: "Ragnar updated the location: Northumbria"),
// ];

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
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController =
      ScrollController(keepScrollOffset: true);

  @override
  Widget build(BuildContext context) {
    final String uid = AuthService().currentUser!.uid;
    final comments = List<Comment>.from(widget.raid.comments);
    // final bloc = context.read<RaidBloc>();

    // void _sendComment(Comment comment) {
    //   final newComments = List<Comment>.from(comments)..add(comment);
    //   final Raid update = widget.raid.copyWith(comments: newComments);
    //   bloc.add(EditRaid([widget.raid, update]));
    // }

    SchedulerBinding.instance?.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.ease,
      );
    });

    void _submitComment(BuildContext context) {
      final comment = Comment(
        message: _textController.text,
        sender: uid,
        timeStamp: DateTime.now(),
      );

      context.read<CommentBloc>().add(SubmitComment(comment));

      _textController.clear();
    }

    return BlocProvider(
      create: (context) => CommentBloc(
        docId: widget.raid.docId!,
        store: DatabaseService(),
      ),
      child: BlocBuilder<CommentBloc, CommentState>(builder: (context, state) {
        final comments = state.comments;
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 45.0),
              child: ListView.builder(
                controller: _scrollController,
                itemCount: comments.length,
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 10),
                // physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final Comment comment = comments[index];

                  if (comment.sender.isEmpty) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
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
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        decoration: const InputDecoration(
                            hintText: "Write a comment...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        _submitComment(context);
                      },
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
      }),
    );
  }
}
