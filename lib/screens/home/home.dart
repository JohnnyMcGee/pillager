import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pillager/bloc/bloc.dart';
import 'package:pillager/widgets/expandable_datatable.dart';

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
          TextButton.icon(
            onPressed: () {
              context.read<SignInBloc>().add(SignOutButtonPressed());
            },
            icon: Icon(
              Icons.person,
              color: Colors.blueGrey[400],
            ),
            label: Text(
              'Sign Out',
              style: TextStyle(
                color: Colors.blueGrey[400],
              ),
            ),
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
