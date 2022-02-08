import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pillager/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pillager/bloc/bloc.dart';
import 'package:pillager/services/services.dart';

class ProfileEditor extends StatefulWidget {
  // final User user;
  // final Viking viking;

  const ProfileEditor({Key? key}) : super(key: key);

  @override
  State<ProfileEditor> createState() => _ProfileEditorState();
}

class _ProfileEditorState extends State<ProfileEditor> {
  final _formKey = GlobalKey<FormState>();
  final user = AuthService().currentUser;

  String? _email;
  String? _firstName;
  String? _lastName;
  bool? _isBerserker;
  bool? _isEarl;

  Future<void> _showDeleteDialog(BuildContext context) async {
    final bool? confirm = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Delete My Account",
            textAlign: TextAlign.center,
          ),
          content: const Text(
            """Are you sure you want to delete this account?
            You will not be able to recover it.""",
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text("Delete Account"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      context.read<SignInBloc>().add(DeleteAccount());
      Navigator.pop(context);
    }
  }

  Map<String, Object> get _vikingUpdate {
    final vikingUpdate = {
      "firstName": _firstName,
      "lastName": _lastName,
      "isBerserker": _isBerserker,
      "isEarl": _isEarl,
    }..removeWhere((k, v) => v == null);

    return Map<String, Object>.from(vikingUpdate);
  }

  void _updateProfile(BuildContext context, Viking viking) {
    if (_email is String) {
      user?.updateEmail(_email!);
    }

    final bloc = context.read<VikingBloc>();

    bloc.add(UpdateViking(
          viking: viking,
          update: _vikingUpdate,
        ));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VikingBloc, VikingState>(
      builder: (context, state) {
        final viking = state.vikings[user?.uid];

        if (user is User && viking is Viking) {
          return Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Edit Profile",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                TextFormField(
                  initialValue: _email ?? user!.email,
                  onChanged: (value) => setState(() {
                    _email = value;
                  }),
                ),
                TextFormField(
                  initialValue: _firstName ?? viking.firstName,
                  onChanged: (value) => setState(() {
                    _firstName = value;
                  }),
                ),
                TextFormField(
                  initialValue: _lastName ?? viking.lastName,
                  onChanged: (value) => setState(() {
                    _lastName = value;
                  }),
                ),
                Switch(
                    value: _isBerserker ?? viking.isBerserker,
                    onChanged: (value) => setState(() {
                          _isBerserker = value;
                        })),
                Switch(
                    value: _isEarl ?? viking.isEarl,
                    onChanged: (value) => setState(() {
                          _isEarl = value;
                        })),
                const SizedBox(height: 20),
                TextButton(
                  child: const Text(
                    "Delete My Account",
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () => _showDeleteDialog(context),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  child: const Text(
                    "Update Profile",
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () => _updateProfile(context, viking),
                ),
              ],
            ),
          );
        } else {
          return SizedBox(
            height: 225,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Loading Profile...",
                    style: Theme.of(context).textTheme.headline5),
                SpinKitFoldingCube(
                    color: Theme.of(context).colorScheme.secondary),
              ],
            ),
          );
        }
      },
    );
  }
}