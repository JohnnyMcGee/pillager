import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  const USE_EMULATOR = true;

  if (USE_EMULATOR) {
    FirebaseFirestore.instance.settings = const Settings(
        host: "http://localhost:8080",
        sslEnabled: false,
        persistenceEnabled: true);
    FirebaseAuth.instance.useAuthEmulator("localhost", 9099);
  }

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
              signInBloc: context.read<SignInBloc>(),
            ),
          ),
          BlocProvider(
            create: (context) => RaidBloc(
              store: DatabaseService(),
              signInBloc: context.read<SignInBloc>(),
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
