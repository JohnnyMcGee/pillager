import 'package:flutter/material.dart';
import 'package:pillager/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileEditor extends StatelessWidget {
  const ProfileEditor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileEditorBloc(
        signInBloc: context.read<SignInBloc>(),
        vikingBloc: context.read<VikingBloc>(),
      )..add(LoadProfile()),
      child: BlocBuilder<ProfileEditorBloc, ProfileEditorState>(
          builder: (context, state) {
        if (state is ProfileEditorSubmitted) {
          Navigator.pop(context, {
            "email": state.email,
            "viking": state.viking,
            "update": state.update,
          });
        }

        final bloc = context.read<ProfileEditorBloc>();
        if (state is ProfileEditorLoaded) {
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
                TextFormField(
                  initialValue: state.email,
                  onChanged: (val) => bloc.add(EditProfile({"email": val})),
                ),
                TextFormField(
                  initialValue: state.firstName,
                  onChanged: (val) => bloc.add(EditProfile({"firstName": val})),
                ),
                TextFormField(
                  initialValue: state.lastName,
                  onChanged: (val) => bloc.add(EditProfile({"lastName": val})),
                ),
                Switch(
                  value: state.isBerserker,
                  onChanged: (val) =>
                      bloc.add(EditProfile({"isBerserker": val})),
                ),
                Switch(
                  value: state.isEarl,
                  onChanged: (val) => bloc.add(EditProfile({"isEarl": val})),
                ),
                TextButton(
                  child: const Text(
                    "Update Profile",
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () => bloc.add(UpdateProfile()),
                ),
              ],
            ),
          );
        } else {
          return const Text("Loading");
        }
      }),
    );
  }
}
