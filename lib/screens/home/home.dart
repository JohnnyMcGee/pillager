import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pillager/bloc/bloc.dart';
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
    showDialog(
        context: context,
        builder: (context) {
            return ProfileEditor();
        }); 
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
        final textTheme = Theme.of(context).textTheme;
        final colorScheme = Theme.of(context).colorScheme;

        if (state is VikingLoaded) {
          String uid = (context.read<SignInBloc>().state as LoggedIn).user.uid;

          final welcomeText = (state.vikings.containsKey(uid))
              ? "Welcome, ${state.vikings[uid]!.fullName}!"
              : "Welcome, Viking Friend!";

          WidgetsBinding.instance?.addPostFrameCallback((_) => _showProfileEditor(context));

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                  ),
                  child: Text(
                    welcomeText,
                    style: textTheme.headline4
                        ?.copyWith(color: colorScheme.primaryVariant),
                  ),
                ),
                const Expanded(
                  child: ExpandableDataTable(),
                ),
              ],
            ),
          );
        } else {
          return SpinKitFoldingCube(color: colorScheme.secondary);
        }
      }),
    );
  }
}
