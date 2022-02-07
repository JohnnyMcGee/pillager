import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:pillager/bloc/bloc.dart';
import 'package:pillager/models/models.dart';
import 'package:pillager/shared.dart';

class RaidForm extends StatefulWidget {
  final String raidId;

  const RaidForm({Key? key, required this.raidId}) : super(key: key);

  @override
  State<RaidForm> createState() => _RaidFormState();
}

class _RaidFormState extends State<RaidForm> {
  final _formKey = GlobalKey<FormState>();
  String? _location;
  int? _numShips;
  DateTime? _arrivalDate;
  Map<String, Object>? _vikings;

  Future<void> _selectDate(BuildContext context, DateTime initialDate) async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(793),
      lastDate: DateTime(2025),
    );

    setState(() {
      _arrivalDate = newDate;
    });
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
      final updatedVikings = Map<String, Object>.from(currentVikings)
        ..putIfAbsent(choice.uid, () => choice);
      setState(() {
        _vikings = updatedVikings;
      });
    }
  }

  void _removeViking(Viking viking, Map<String, Object> currentVikings) {
    final newVikings = Map<String, Object>.from(currentVikings)
      ..removeWhere((k, v) => k == viking.uid);
    setState(() {
      _vikings = newVikings;
    });
  }

  void _submitForm(BuildContext context, Raid raid) {
    final update = {
      "location": _location,
      "arrivalDate": _arrivalDate,
      "numShips": _numShips,
      "vikings": _vikings,
    }..removeWhere((k, v) => v == null);
    context.read<RaidBloc>().add(EditRaid(
          raid,
          Map<String, Object>.from(update),
        ));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<RaidBloc, RaidState>(
      builder: (context, state) {
        Raid raid = state.raids.singleWhere(
          (raid) => raid.docId == widget.raidId,
          orElse: () => Raid.newRaid,
        );

        return Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(
                  'Enter Raid Details',
                  style: textTheme.headline4,
                ),
              ),
              const Divider(
                height: 20.0,
              ),
              ListView(
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 30.0),
                children: [
                  Text("Location: ", style: textTheme.headline5),
                  Row(
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 500.0),
                        child: buildTextFormField(
                          onChanged: (value) =>
                              setState(() => _location = value),
                          initialValue: _location ?? raid.location,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0, top: 30.0),
                    child:
                        Text("Number of Ships: ", style: textTheme.headline5),
                  ),
                  Row(
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 100.0),
                        child: DropdownButtonFormField(
                          value: _numShips ?? raid.numShips,
                          items: List.generate(
                              100,
                              (i) => DropdownMenuItem(
                                    value: i + 1,
                                    child: Text('${i + 1}'),
                                  )),
                          onChanged: (value) =>
                              setState(() => _numShips = value as int),
                          decoration: fieldDecoration,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0, bottom: 10.0),
                    child:
                        Text("Date of Arrival: ", style: textTheme.headline5),
                  ),
                  Row(
                    children: [
                      Text(
                        DateFormat.yMd()
                            .format(_arrivalDate ?? raid.arrivalDate),
                        style: textTheme.headline6?.copyWith(
                            fontWeight: FontWeight.bold, letterSpacing: 1.25),
                      ),
                      IconButton(
                        padding: const EdgeInsets.only(left: 14.0),
                        onPressed: () => _selectDate(
                            context, _arrivalDate ?? raid.arrivalDate),
                        icon: Icon(Icons.calendar_today,
                            color:
                                Theme.of(context).colorScheme.primaryVariant),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0, bottom: 10.0),
                    child: Text("Vikings: ", style: textTheme.headline5),
                  ),
                  ListView(
                    shrinkWrap: true,
                    children: [
                      ...[
                        for (var viking in (_vikings != null)
                            ? (_vikings as Map<String, Object>).values
                            : raid.vikings.values)
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text(
                                      (viking as Viking).fullName,
                                      style: textTheme.subtitle1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () => _removeViking(
                                        viking, _vikings ?? raid.vikings),
                                    icon: const Icon(
                                      Icons.close,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                      ],
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: TextButton(
                          onPressed: () => _selectAssignViking(
                              context, _vikings ?? raid.vikings),
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
                                      ?.copyWith(color: colorScheme.primary),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 30.0),
                child: ElevatedButton(
                    child: Text(
                      'SAVE',
                      style: Theme.of(context).textTheme.button?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    onPressed: () => _submitForm(context, raid),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 40.0)),
                    )),
              ),
            ],
          ),
        );
      },
    );
  }
}
