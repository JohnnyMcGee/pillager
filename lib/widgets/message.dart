import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pillager/models/models.dart';
import 'package:pillager/bloc/bloc.dart';
import 'package:pillager/themes.dart';

class Message extends StatelessWidget {
  final Comment comment;
  final bool received;
  final void Function() onDelete;
  final bool isSelected;
  final void Function(Comment) onSelect;

  const Message({
    Key? key,
    required this.comment,
    required this.received,
    required this.onDelete,
    required this.onSelect,
    required this.isSelected,
  }) : super(key: key);

  Color _color() {
    Color c;
    if (received) {
      c = (isSelected ? scheme.secondaryVariant : scheme.secondary);
    } else {
      c = (isSelected ? scheme.primaryVariant : scheme.primary);
    }
    return c.withOpacity(.85);
  }

  @override
  Widget build(BuildContext context) {
    final vikings = context.read<VikingBloc>().state.vikings;
    final Viking? sender = vikings[comment.sender];
    final Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Align(
        alignment: received ? Alignment.topLeft : Alignment.topRight,
        child: Column(
          crossAxisAlignment:
              (received) ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            Visibility(
              visible: received,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  (sender is Viking) ? sender.fullName : "",
                  textAlign: (received) ? TextAlign.left : TextAlign.right,
                  style: const TextStyle(
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment:
                  received ? MainAxisAlignment.start : MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: size.width * .4,
                  child: InkWell(
                    onTap: () => onSelect(comment),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: _color(),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        comment.message,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Visibility(
                    visible: isSelected && !received,
                    child: IconButton(
                      onPressed: onDelete,
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
