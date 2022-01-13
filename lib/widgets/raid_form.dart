import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pillager/bloc/bloc.dart';
import 'package:pillager/models/models.dart';
import 'package:pillager/widgets/expandable_datatable.dart';

class RaidForm extends StatefulWidget {
  Raid raid;

  RaidForm({Key? key, required this.raid}) : super(key: key);

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
    return BlocBuilder<DatabaseBloc, DatabaseState>(builder: (context, state) {
      if (state is DatabaseLoaded) {
        Raid raid = state.raids[0];
        return Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                'Enter Raid Details',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                initialValue: _location ?? raid.location,
                onChanged: (val) => setState(() => _location = val),
              ),
              SizedBox(
                height: 20.0,
              ),
              DropdownButtonFormField(
                value: _numShips ?? raid.numOfShips,
                items: List.generate(100, (index) => index).map((number) {
                  return DropdownMenuItem(
                    value: number,
                    child: Text(number.toString()),
                  );
                }).toList(),
                onChanged: (val) =>
                    setState(() => _numShips = val as int),
              ),
              SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    (_arrivalDate is DateTime)
                        ? readableDate(_arrivalDate!)
                        : readableDate(raid.arrivalDate),
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
                    icon: Icon(Icons.calendar_today),
                  ),
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color?>(Colors.blueGrey[900]),
                  ),
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    final raidUpdate = {
                      "docId":raid.docId,
                      "location":_location,
                      "numShips":_numShips,
                      "arrivalDate":_arrivalDate,
                    };
                    print(raidUpdate.toString());
                    context.read<DatabaseBloc>().add(RaidEditorSaveButtonPressed(data: raidUpdate));
                    Navigator.pop(context);
                  }),
            ],
          ),
        );
      } else {
        return Text("Loading");
      }
    });
  }
}
