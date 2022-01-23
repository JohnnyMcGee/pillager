import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:pillager/bloc/bloc.dart';
import 'package:pillager/models/models.dart';

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
    print(update);
    context.read<RaidBloc>().add(EditRaid(
          raid,
          Map<String, Object>.from(update),
        ));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
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
              const Text(
                'Enter Raid Details',
                style: TextStyle(fontSize: 18.0),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                initialValue: _location ?? raid.location,
                onChanged: (value) => setState(() => _location = value),
              ),
              const SizedBox(
                height: 30,
              ),
              DropdownButtonFormField(
                value: _numShips ?? raid.numShips,
                items: List.generate(
                    100,
                    (i) => DropdownMenuItem(
                          value: i + 1,
                          child: Text('${i + 1}'),
                        )),
                onChanged: (value) => setState(() => _numShips = value as int),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat.yMd().format(_arrivalDate ?? raid.arrivalDate),
                    style: TextStyle(
                      color: Colors.blueGrey[900],
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () =>
                        _selectDate(context, _arrivalDate ?? raid.arrivalDate),
                    icon: const Icon(Icons.calendar_today),
                  ),
                ],
              ),
              const SizedBox(
                height: 30.0,
              ),
              const Text(
                "Vikings:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 200.0,
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
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
                                Text(
                                  (viking as Viking).fullName,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
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
                          children: const [
                            Icon(Icons.add),
                            Text("Assign a Viking"),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color?>(Colors.blueGrey[900]),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => _submitForm(context, raid),
              ),
            ],
          ),
        );
      },
    );
  }
}
