import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pillager/bloc/sign_in/sign_in.dart';
import 'package:pillager/services/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthService auth;
  final DatabaseService store;

  SignInBloc({required this.auth, required this.store})
      : super(SignInInitial()) {
    auth.user.listen((user) => add(UserStateChange(user)));

    on<SignInEmailButtonPressed>(_onSignInEmailButtonPressed);
    on<RegisterEmailButtonPressed>(_onRegisterEmailButtonPressed);
    on<SignOutButtonPressed>(_onSignOutButtonPressed);
    on<SignInSuccess>((event, emit) => emit(LoggedIn(user: event.user)));
    on<SignInFailure>(_onSignInFailure);
    on<UserStateChange>(_onUserStateChange);
    on<DeleteAccount>(_onDeleteAccount);
  }

  void _onSignInEmailButtonPressed(
      SignInEmailButtonPressed event, Emitter<SignInState> emit) async {
    emit(SignInLoading());

    User? user = await auth.signIn(event.email, event.password);
    if (user != null) {
      add(SignInSuccess(user: user));
    } else {
      add(SignInFailure(
          message: 'Invalid email or password. Please try again.'));
    }
  }

  void _onRegisterEmailButtonPressed(
      RegisterEmailButtonPressed event, Emitter<SignInState> emit) async {
    emit(SignInLoading());

    String capitalize(String s) =>
        (s.isNotEmpty) ? s[0].toUpperCase() + s.substring(1) : s;

    final String first = capitalize(event.firstName);
    final String last = capitalize(event.lastName);

    User? user = await auth.registerWithEmailAndPassword(
        event.email, event.password, first, last);
    if (user != null) {
      store.createNewViking(
        user.uid,
        {
          "firstName": first,
          "lastName": last,
        },
      );
      add(SignInSuccess(user: user));
    } else {
      add(SignInFailure(
          message: 'Unable to create account. Please try again.'));
    }
  }

  Future<void> _onSignOutButtonPressed(
      SignOutButtonPressed event, Emitter emit) async {
    await auth.signOut();
    emit(LoggedOut());
  }

  Future<void>? _onSignInFailure(SignInFailure event, Emitter emit) {
    emit(LoggedOut());
  }
  
  void _onUserStateChange(UserStateChange event, Emitter emit) {
    final user = event.user;
    if (user is User) {
      emit(LoggedIn(user: user));
    } else {
      emit(LoggedOut());
    }
  }

    void _onDeleteAccount(DeleteAccount event, Emitter emit) {
      final user = auth.currentUser;
      if (user is User) {
        user.delete();
        emit(LoggedOut());
      }
  }
  
}
