import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pillager/bloc/bloc.dart';
import 'package:pillager/models/models.dart';

class AssignViking extends StatelessWidget {
  final Map<String, Object> vikings;
  final void Function(Map<String, Object>) setVikings;
  const AssignViking(
      {Key? key, required this.vikings, required this.setVikings})
      : super(key: key);

  void _removeViking(Viking viking, Map<String, Object> currentVikings) {
    final newVikings = Map<String, Object>.from(currentVikings)
      ..removeWhere((k, v) => k == viking.uid);

    setVikings(newVikings);
  }

  Future<String?> _selectAssignViking(
      BuildContext context, Map<String, Object> currentVikings) async {
    List<Viking> options = List<Viking>.from(context
        .read<VikingBloc>()
        .state
        .vikings
        .values
        .where((v) => !currentVikings.keys.contains(v.uid)));

    Viking? choice = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text("Assign a Viking"),
          children: [
            for (var option in options)
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, option);
                },
                child: Text(option.fullName),
              ),
          ],
        );
      },
    );
    if (choice != null) {
      final newVikings = Map<String, Object>.from(currentVikings)
        ..putIfAbsent(choice.uid, () => choice);

      setVikings(newVikings);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 300.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              ...[
                for (var viking in vikings.values)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 12.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              (viking as Viking).fullName,
                              style: textTheme.subtitle1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                            onPressed: () => _removeViking(viking, vikings),
                            icon: const Icon(
                              Icons.close,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
              ],
            ],
          ),
        ),
        TextButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0)),
          ),
          onPressed: () => _selectAssignViking(context, vikings),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Icon(Icons.add),
              ),
              Expanded(
                child: Text(
                  "Assign a Viking",
                  style: textTheme.subtitle1
                      ?.copyWith(color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
