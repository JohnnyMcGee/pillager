import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pillager/bloc/bloc.dart';
import 'package:pillager/models/models.dart';
import 'package:pillager/services/services.dart';
import 'package:pillager/widgets/widgets.dart';


class RaidChat extends StatefulWidget {
  final String raidId;
  const RaidChat({Key? key, required this.raidId}) : super(key: key);

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
        docId: widget.raidId,
        store: DatabaseService(),
      ),
      child: BlocBuilder<CommentBloc, CommentState>(builder: (context, state) {
        final comments = state.comments;
        final bloc = context.read<CommentBloc>();
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
                    onDelete: () => bloc.add(DeleteComment(comment)),
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
