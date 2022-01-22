import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pillager/models/models.dart';
import 'package:pillager/bloc/bloc.dart';

class Message extends StatelessWidget {
  final Comment comment;
  final bool received;
  const Message({Key? key, required this.comment, required this.received})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vikings = context.read<VikingBloc>().state.vikings;
    final Viking? sender = vikings[comment.sender];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Align(
        alignment: received ? Alignment.topLeft : Alignment.topRight,
        child: Column(
          crossAxisAlignment: (received) ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            Visibility(
              visible: received,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  (sender is Viking)
                  ? sender.fullName
                  : "",
                  textAlign: (received) ? TextAlign.left : TextAlign.right,
                  style: const TextStyle(
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
            Container(
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
          ],
        ),
      ),
    );
  }
}