import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pillager/bloc/bloc.dart';
import 'package:pillager/models/models.dart';
import 'package:pillager/services/authenticate.dart';
import 'package:pillager/widgets/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  Future<void> openRaidConsole(context) async {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Wrap(
            children: const [
              RaidConsole(raidId: "AJWQQyI8eM4uqmHtPbEN"),
            ],
          );
        });
  }

  void _showProfileEditor(BuildContext context) async {
    final user = AuthService().currentUser;
    final vikingBloc = context.read<VikingBloc>();
    final profile = vikingBloc.state.vikings[user?.uid];

    if (profile is Viking && user is User) {
      Map<String, Object>? profileUpdate = await showDialog(
          context: context,
          builder: (context) {
            return SimpleDialog(
              children: [
                ProfileEditor(
                  user: user,
                  viking: profile,
                ),
              ],
            );
          });

      if (profileUpdate != null) {
        final email = profileUpdate["email"];

        vikingBloc.add(UpdateViking(
            viking: profile,
            update: profileUpdate..removeWhere((k, v) => k == "email")));

        if (email is String) {
          user.updateEmail(email);
        }
      }
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pillager'),
        elevation: 0.0,
        actions: <Widget>[
          PopupMenuButton(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(Icons.person),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'My Account',
                    ),
                  ),
                ],
              ),
            ),
            onSelected: (val) {
              switch (val) {
                case 0:
                  _showProfileEditor(context);
                  break;
                case 1:
                  context.read<SignInBloc>().add(SignOutButtonPressed());
                  break;
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                child: Text('Edit Profile'),
                value: 0,
              ),
              const PopupMenuItem(
                child: Text('Sign Out'),
                value: 1,
              ),
            ],
          ),
        ],
      ),
      body: BlocBuilder<VikingBloc, VikingState>(builder: (context, state) {
        String uid = (context.read<SignInBloc>().state as LoggedIn).user.uid;

        if (state is VikingLoaded) {
          WidgetsBinding.instance?.addPostFrameCallback((_) => openRaidConsole(context));

          return Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50.0,
                    vertical: 20.0,
                  ),
                  child: Text(
                    (state is VikingLoaded && state.vikings.containsKey(uid))
                        ? "Welcome ${state.vikings[uid]!.fullName}!"
                        : "Welcome Viking Friend!",
                    style: const TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              const Expanded(
                child: ExpandableDataTable(),
              ),
            ],
          );
        } else {
          return SpinKitFoldingCube(
              color: Theme.of(context).colorScheme.secondary);
        }
      }),
    );
  }
}
