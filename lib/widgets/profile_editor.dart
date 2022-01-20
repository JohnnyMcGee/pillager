import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pillager/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pillager/bloc/bloc.dart';

class ProfileEditor extends StatefulWidget {
  final User user;
  final Viking viking;

  const ProfileEditor({Key? key, required this.user, required this.viking})
      : super(key: key);

  @override
  State<ProfileEditor> createState() => _ProfileEditorState();
}

class _ProfileEditorState extends State<ProfileEditor> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _firstName;
  String? _lastName;
  bool? _isBerserker;
  bool? _isEarl;

  Map<String, Object> _profileUpdate() {
    var changes = {
      "email": _email,
      "firstName": _firstName,
      "lastName": _lastName,
      "isBerserker": _isBerserker,
      "isEarl": _isEarl,
    }..removeWhere((k, v) => v == null);

    return Map<String, Object>.from(changes);
  }

  Future<void> _showDeleteDialog(BuildContext context) async {
    final bool? confirm = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete My Account", textAlign: TextAlign.center,),
          content: Text(
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Text(
            "Edit Profile",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          TextFormField(
            initialValue: _email ?? widget.user.email,
            onChanged: (value) => setState(() {
              _email = value;
            }),
          ),
          TextFormField(
            initialValue: _firstName ?? widget.viking.firstName,
            onChanged: (value) => setState(() {
              _firstName = value;
            }),
          ),
          TextFormField(
            initialValue: _lastName ?? widget.viking.lastName,
            onChanged: (value) => setState(() {
              _lastName = value;
            }),
          ),
          Switch(
              value: _isBerserker ?? widget.viking.isBerserker,
              onChanged: (value) => setState(() {
                    _isBerserker = value;
                  })),
          Switch(
              value: _isEarl ?? widget.viking.isEarl,
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
            onPressed: () => Navigator.pop(context, _profileUpdate()),
          ),
        ],
      ),
    );
  }
}
