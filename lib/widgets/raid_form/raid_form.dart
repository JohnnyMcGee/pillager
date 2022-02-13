import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:pillager/bloc/bloc.dart';
import 'package:pillager/models/models.dart';
import 'package:pillager/shared.dart';

part './assign_viking.dart';
part './date_selector.dart';

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

    return BlocBuilder<RaidBloc, RaidState>(
      builder: (context, state) {
        Raid raid = state.raids.singleWhere(
          (raid) => raid.docId == widget.raidId,
          orElse: () => Raid.newRaid,
        );

        return Container(
          color: Theme.of(context).colorScheme.surface,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    'Enter Raid Details',
                    style: textTheme.headline5,
                  ),
                ),
                const Divider(
                  height: 20.0,
                ),
                Container(
                  constraints: const BoxConstraints(maxWidth: 560.0),
                  alignment: Alignment.topLeft,
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30.0),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Text("Location: ", style: textTheme.headline5),
                      ),
                      TextFormField(
                        initialValue: _location ?? raid.location,
                        onChanged: (value) => setState(() {
                          _location = value;
                        }),
                        decoration:
                            fieldDecoration.copyWith(hintText: "location"),
                        autofocus: true,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0, top: 40.0),
                        child: Text("Number of Ships: ",
                            style: textTheme.headline5),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: ConstrainedBox(
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
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0, bottom: 10.0),
                        child: Text("Date of Arrival: ",
                            style: textTheme.headline5),
                      ),
                      DateSelector(
                        arrivalDate: _arrivalDate ?? raid.arrivalDate,
                        setArrivalDate: (newDate) => setState(() {
                          _arrivalDate = newDate;
                        }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0, bottom: 10.0),
                        child: Text("Vikings: ", style: textTheme.headline5),
                      ),
                      AssignViking(
                        vikings: _vikings ?? raid.vikings,
                        setVikings: (newVikings) => setState(() {
                          _vikings = newVikings;
                        }),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 30.0),
                  child: ElevatedButton(
                    child: Text(
                      'SAVE',
                      style: textTheme.button
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    onPressed: () => _submitForm(context, raid),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 40.0)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
