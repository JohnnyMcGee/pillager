import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pillager/bloc/bloc.dart';

class ProfileDialog extends StatelessWidget {
  const ProfileDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return AlertDialog(content: BlocBuilder<VikingBloc, VikingState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            children: const [
              Text(
                "Edit Profile",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              TextField(),
            ],
          ),
        );
      },
    ));
  }
}
