import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pillager/bloc/bloc.dart';
import 'package:pillager/models/models.dart';
import 'package:pillager/widgets/expandable_datatable.dart';

class RaidForm extends StatefulWidget {
  const RaidForm({Key? key}) : super(key: key);

  @override
  _RaidFormState createState() => _RaidFormState();
}

class _RaidFormState extends State<RaidForm> {
  final _formKey = GlobalKey<FormState>();

  // form values
  String? _location;
  String? _numShips;
  String? _arrivalDate;

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<DatabaseBloc, DatabaseState>(
        builder: (context, state) {
          if (state is DatabaseLoaded) {
            Raid raid = state.raids[0];
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Update your Armament',
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
                  TextFormField(
                    initialValue: _numShips ?? raid.numOfShips.toString(),
                    onChanged: (val) => setState(() => _numShips = val),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    initialValue: _arrivalDate ?? readableDate(raid.arrivalDate),
                    onChanged: (val) => setState(() => _arrivalDate = val),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color?>(
                          Colors.blueGrey[900]),
                    ),
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                        print('''
                        $_location,
                        $_numShips,
                        $_arrivalDate
                        ''');
                        Navigator.pop(context);
                      }
                  ),
                ],
              ),
            );
          } else {
            return Text("Loading");
          }
        });
  }
}
