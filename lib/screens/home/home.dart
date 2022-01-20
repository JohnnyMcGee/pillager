import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pillager/bloc/bloc.dart';
import 'package:pillager/models/models.dart';
import 'package:pillager/widgets/widgets.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  void _showProfileEditor(BuildContext context) async {
    final signInBloc = context.read<SignInBloc>();
    final vikingBloc = context.read<VikingBloc>();
    final user = (signInBloc.state as LoggedIn).user;
    final profile = vikingBloc.state.vikings[user.uid];

    if (profile != null) {
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
        // signInBloc.add(UpdateUser({"email": profileUpdate["email"]}));
        vikingBloc.add(UpdateViking(viking:profile, update:profileUpdate));
      }
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: const Text('Pillager'),
        elevation: 0.0,
        actions: <Widget>[
          PopupMenuButton(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.person),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'My Account',
                      style: TextStyle(
                        color: Colors.blueGrey[400],
                      ),
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
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 50.0,
                vertical: 20.0,
              ),
              child: BlocBuilder<VikingBloc, VikingState>(
                  builder: (context, state) {
                String uid =
                    (context.read<SignInBloc>().state as LoggedIn).user.uid;

                return Text(
                  (state is VikingLoaded && state.vikings.containsKey(uid))
                      ? "Welcome ${state.vikings[uid]!.fullName}!"
                      : "Welcome Viking Friend!",
                  style: const TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 20.0,
                  ),
                );
              }),
            ),
          ),
          ExpandableDataTable(),
        ],
      ),
    );
  }
}
