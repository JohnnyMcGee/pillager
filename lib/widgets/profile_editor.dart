import 'package:flutter/material.dart';
import 'package:pillager/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileEditor extends StatelessWidget {
  const ProfileEditor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileEditorBloc(),
      child: BlocBuilder<ProfileEditorBloc, ProfileEditorState>(
          builder: (context, state) {
        return Form(
          child: Column(
            children: [
              const Text(
                "Edit Profile",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              const TextField(),
              const TextField(),
              const TextField(),
              Switch(
                value: false,
                onChanged: (val) {
                  print(val);
                },
              ),
              Switch(
                value: false,
                onChanged: (val) {
                  print(val);
                },
              ),
              TextButton(
                child: const Text(
                  "Update Profile",
                  textAlign: TextAlign.center,
                ),
                onPressed: () => print("button pressed"),
              ),
            ],
          ),
        );
      }),
    );
  }
}
