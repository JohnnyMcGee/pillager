import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pillager/bloc/sign_in/sign_in.dart';
import 'package:pillager/services/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthService auth;

  SignInBloc({required this.auth}) : super(SignInInitial()) {
    on<SignInEmailButtonPressed>(_onSignInEmailButtonPressed);
    on<RegisterEmailButtonPressed>(_onRegisterEmailButtonPressed);
    on<SignOutButtonPressed>(_onSignOutButtonPressed);
    on<SignInSuccess>((event, emit) => emit(LoggedIn(user: event.user)));
    on<SignInFailure>(_onSignInFailure);
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

    User? user =
        await auth.registerWithEmailAndPassword(event.email, event.password, event.firstName, event.lastName);
    if (user != null) {
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
}
