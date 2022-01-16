import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:pillager/bloc/bloc.dart';
import 'package:pillager/models/models.dart';

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

  Future<void> _selectDate(BuildContext context, DateTime initialDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(793),
      lastDate: DateTime(2025),
    );

    if (picked != null && picked != _arrivalDate) {
      setState(() {
        _arrivalDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RaidBloc, RaidState>(builder: (context, state) {
      if (state is RaidLoaded) {
        Raid raid = widget.raid;
        return Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                'Enter Raid Details',
                style: TextStyle(fontSize: 18.0),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextFormField(
                initialValue: _location ?? raid.location,
                onChanged: (val) => setState(() => _location = val),
              ),
              const SizedBox(
                height: 20.0,
              ),
              DropdownButtonFormField(
                value: _numShips ?? raid.numShips,
                items: List.generate(100, (index) => index).map((number) {
                  return DropdownMenuItem(
                    value: number,
                    child: Text(number.toString()),
                  );
                }).toList(),
                onChanged: (val) => setState(() => _numShips = val as int),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    (_arrivalDate is DateTime)
                        ? DateFormat.yMd().format(_arrivalDate!)
                        : raid.arrivalDateFormatted,
                    style: TextStyle(
                      color: Colors.blueGrey[900],
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => _selectDate(
                      context,
                      (_arrivalDate is DateTime)
                          ? _arrivalDate!
                          : raid.arrivalDate,
                    ),
                    icon: const Icon(Icons.calendar_today),
                  ),
                ],
              ),
              const SizedBox(
                height: 30.0,
              ),
              const Text(
                "Vikings:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 100.0,
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  children: [
                    ...[
                      for (var name in raid.vikingNameList)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                          ),
                        )
                    ],
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add),
                          TextButton(
                            child: Text("Assign a Viking"),
                            onPressed: () => print("Assign a Viking"),
                          ),
                        ],
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
                  onPressed: () async {
                    final raidUpdate = {
                      "docId": raid.docId,
                      "location": _location,
                      "numShips": _numShips,
                      "arrivalDate": _arrivalDate,
                    };
                    context
                        .read<RaidBloc>()
                        .add(RaidEditorSaveButtonPressed(data: raidUpdate));
                    Navigator.pop(context);
                  }),
            ],
          ),
        );
      } else {
        return const Text("Loading");
      }
    });
  }
}
