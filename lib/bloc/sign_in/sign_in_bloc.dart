import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pillager/bloc/sign_in/sign_in.dart';
import 'package:pillager/services/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthService auth;

  SignInBloc({required this.auth}) : super(SignInInitial()) {
    assert(auth != null);
    on<SignInEmailButtonPressed>(_onSignInEmailButtonPressed);
    on<SignInSuccess>((event, emit) => emit(LoggedIn(user: event.user)));
    on<SignInFailure>((event, emit) {print(event.message); emit(LoggedOut());});
  }

  void _onSignInEmailButtonPressed(SignInEmailButtonPressed event, Emitter<SignInState> emit) async {
    print("Event handled!");
    
    emit(SignInLoading());

    User? user = await auth.signIn(event.email, event.password);
    if (user != null) {
      add(SignInSuccess(user: user));
    } else {
      add(SignInFailure(
          message: 'Invalid email or password. Please try again.'));
    }
  }

}
