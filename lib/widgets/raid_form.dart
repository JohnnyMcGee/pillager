import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:pillager/bloc/bloc.dart';
import 'package:pillager/models/models.dart';

const List<String> options = ["Viking1", "Viking2", "Viking3"];

class RaidForm extends StatefulWidget {
  final Raid raid;

  const RaidForm({Key? key, required this.raid}) : super(key: key);

  @override
  _RaidFormState createState() => _RaidFormState();
}

class _RaidFormState extends State<RaidForm> {
  final _formKey = GlobalKey<FormState>();

  // form values
  String? _location;
  int? _numShips;
  DateTime? _arrivalDate;
  Map<String, Viking>? _vikings;

  Future<void> _selectDate(BuildContext context, DateTime initialDate) async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(793),
      lastDate: DateTime(2025),
    );

    context.read<RaidFormBloc>().add(EditForm({"arrivalDate": newDate}));
  }

  Future<void> _selectAssignViking(
      BuildContext context, List<String> currentVikings) async {
    String? choice = await showDialog(
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
                child: Text(option),
              ),
          ],
        );
      },
    );
    print(choice);
  }

  Future<void> _onSave(BuildContext context) async {
    final raidUpdate = {
      "docId": widget.raid.docId,
      "location": _location,
      "numShips": _numShips,
      "arrivalDate": _arrivalDate,
    };
    context.read<RaidBloc>().add(RaidEditorSaveButtonPressed(data: raidUpdate));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RaidFormBloc(
        raidBloc: context.read<RaidBloc>(),
      )..add(OpenRaidForm(data: widget.raid)),
      child: BlocBuilder<RaidFormBloc, RaidFormState>(
        builder: (context, state) {
          RaidFormBloc bloc = context.read<RaidFormBloc>();
          if (state is RaidFormLoaded) {
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
                    initialValue: state.location,
                    onChanged: (val) => bloc.add(EditForm({"location": val})),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  DropdownButtonFormField(
                    value: state.numShips,
                    items: List.generate(
                      100,
                      (i) => DropdownMenuItem(
                        value: i + 1,
                        child: Text('${i + 1}'),
                      ),
                    ),
                    onChanged: (val) => bloc.add(EditForm({"numShips": val!})),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat.yMd().format(state.arrivalDate),
                        style: TextStyle(
                          color: Colors.blueGrey[900],
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () =>
                            _selectDate(context, state.arrivalDate),
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
                    height: 100.0,
                    child: ListView(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      children: [
                        ...[
                          for (var name in (state.raid.vikingNameList))
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  name,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                            )
                        ],
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: TextButton(
                            onPressed: () =>
                                _selectAssignViking(context, const [""]),
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
                      backgroundColor: MaterialStateProperty.all<Color?>(
                          Colors.blueGrey[900]),
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {bloc.add(FormSubmit()); Navigator.pop(context);},
                  ),
                ],
              ),
            );
          } else {
            return const Text("loading");
          }
        },
      ),
    );
  }
}
