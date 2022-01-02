import 'package:flutter/material.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> armTypes = ['sword', 'axe', 'bow', 'twin katana'];

  // form values
  String? _currentName;
  String? _currentArmType;
  int? _currentSize;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);

    return StreamBuilder<MyUserData>(
        stream: DatabaseService(uid: user?.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            MyUserData? userData = snapshot.data;
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
                    initialValue: _currentName ?? userData?.name,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    initialValue: _currentName ?? userData?.name,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    initialValue: _currentName ?? userData?.name,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color?>(
                          Colors.blueGrey[900]),
                    ),
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                        print();
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
