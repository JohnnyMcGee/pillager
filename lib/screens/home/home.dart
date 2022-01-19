import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pillager/bloc/bloc.dart';
import 'package:pillager/widgets/expandable_datatable.dart';
import 'package:pillager/widgets/widgets.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

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
                  showDialog(context: context, builder: ((context) {
                    return const ProfileDialog();
                  }));
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
