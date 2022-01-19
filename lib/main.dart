import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './app.dart';
import './bloc/bloc.dart';
import './config.dart';

import './services/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: options,
  );

  BlocOverrides.runZoned(
    () {
      runApp(MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SignInBloc(
              auth: AuthService(),
              store: DatabaseService(),
            ),
          ),
          BlocProvider(
            create: (context) => VikingBloc(
              store: DatabaseService(),
            ),
            lazy:false,
          ),
          BlocProvider(
            create: (context) => RaidBloc(
              store: DatabaseService(),
              vikingBloc: context.read<VikingBloc>(),
            ),
          ),
        ],
        child: const PillagerApp(),
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}
