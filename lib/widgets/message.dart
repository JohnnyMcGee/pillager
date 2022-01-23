import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pillager/models/models.dart';
import 'package:pillager/bloc/bloc.dart';

class Message extends StatefulWidget {
  final Comment comment;
  final bool received;
  final void Function() onDelete;

  const Message(
      {Key? key,
      required this.comment,
      required this.received,
      required this.onDelete})
      : super(key: key);

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  bool _tapped = false;

  Color _color() {
    if (widget.received) {
      return (_tapped ? Colors.grey[600] : Colors.grey[400]) as Color;
    } else {
      return (_tapped ? Colors.blue[600] : Colors.blue[400] ) as Color;
    }
  }

  @override
  Widget build(BuildContext context) {
    final vikings = context.read<VikingBloc>().state.vikings;
    final Viking? sender = vikings[widget.comment.sender];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Align(
        alignment: widget.received ? Alignment.topLeft : Alignment.topRight,
        child: Column(
          crossAxisAlignment: (widget.received)
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.end,
          children: [
            Visibility(
              visible: widget.received,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  (sender is Viking) ? sender.fullName : "",
                  textAlign:
                      (widget.received) ? TextAlign.left : TextAlign.right,
                  style: const TextStyle(
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: widget.received
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => setState(() {
                    _tapped = !_tapped;
                  }),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: _color(),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      widget.comment.message,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 0.8),
                  child: Visibility(
                    visible: _tapped && !widget.received,
                    child: IconButton(
                      onPressed: widget.onDelete,
                      icon: const Icon(Icons.delete_outline_rounded),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
