import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pillager/bloc/bloc.dart';
import 'package:pillager/models/models.dart';
import 'package:pillager/services/services.dart';
import 'package:pillager/shared.dart';
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
  Comment? _selectedComment;

  void _selectComment(Comment comment) {
    setState(() {
      _selectedComment = comment;
    });
  }

  Future<bool> _confirmDelete(BuildContext context) async {
    final bool? confirmed = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Delete Comment"),
            content: const Text("Are you sure?"),
            actions: [
              ElevatedButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text("Yes")),
              ElevatedButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text("No")),
            ],
          );
        });
    return confirmed ?? false;
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 600),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    final String uid = AuthService().currentUser!.uid;

    void _submitComment(BuildContext context) {
      if (_textController.text.isNotEmpty) {
        final comment = Comment(
          message: _textController.text,
          sender: uid,
          timeStamp: DateTime.now(),
        );

        context.read<CommentBloc>().add(SubmitComment(comment));
        _textController.clear();
      }
    }

    return BlocProvider(
      create: (context) => CommentBloc(
        docId: widget.raidId,
        store: DatabaseService(),
      ),
      child: BlocBuilder<CommentBloc, CommentState>(builder: (context, state) {
        final comments = state.comments;
        final bloc = context.read<CommentBloc>();

        SchedulerBinding.instance
            ?.addPostFrameCallback((_) => _scrollToBottom());

        return GestureDetector(
          onTap: () => setState(() {
            _selectedComment = null;
          }),
          onHorizontalDragStart: (_) => setState(() {
            _selectedComment = null;
          }),
          child: Stack(
            children: [
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: 10.0),
                child: Text("Comments",
                    style: Theme.of(context).textTheme.headline5),
              ),
              Positioned.fill(
                child: Container(
                  color: Theme.of(context).colorScheme.primary.withOpacity(.3),
                  padding: const EdgeInsets.only(
                      top: 54.0, left: 8.0, right: 8.0, bottom: 80.0),
                  child: Container(
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                      color: Colors.white,
                    ),
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
                              ),
                            ),
                          );
                        }

                        return Message(
                          comment: comment,
                          received: uid != comment.sender,
                          onDelete: () async {
                            if (await _confirmDelete(context)) {
                              bloc.add(DeleteComment(comment));
                            }
                            setState(() {
                              _selectedComment = null;
                            });
                          },
                          isSelected: _selectedComment == comment,
                          onSelect: _selectComment,
                        );
                      },
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: const EdgeInsets.only(left: 10, bottom: 20, top: 10),
                  width: double.infinity,
                  child: Row(
                    children: <Widget>[
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _textController,
                          onSubmitted: (_) => _submitComment(context),
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: fieldDecoration.copyWith(
                            hintText: "Write a comment...",
                            hintStyle: const TextStyle(color: Colors.black54),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      SizedBox(
                        height: 40,
                        child: FloatingActionButton(
                          onPressed: () {
                            _submitComment(context);
                          },
                          child: const Icon(Icons.send),
                          elevation: 0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
