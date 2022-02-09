import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pillager/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pillager/bloc/bloc.dart';
import 'package:pillager/services/services.dart';
import 'package:pillager/shared.dart';

part './profile_form.dart';
part './delete_dialog.dart';
part './email_editor.dart';

class ProfileEditor extends StatelessWidget {
  final user = AuthService().currentUser;
  ProfileEditor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: BlocBuilder<VikingBloc, VikingState>(
        builder: (context, state) {
          final viking = state.vikings[user?.uid];

          if (user is User && viking is Viking) {
            return SingleChildScrollView(
              child: SizedBox(
                width: 300.0,
                // child: ProfileForm(profile: viking, user: user as User),
                child: ProfileForm(profile: viking),
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
      ),
    );
  }
}
