import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pillager/bloc/sign_in/sign_in.dart';
import 'package:pillager/services/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthService auth;

  SignInBloc({required this.auth}) : super(SignInInitial()) {
    assert(auth != null);
  }

  @override
  Stream<SignInState> mapEventToState(SignInEvent event) async* {
    if (event is SignInEmailButtonPressed) {
      yield* signInEmailAttempt(event.email, event.password);
    } else if (event is SignInSuccess) {
      yield* mapSignInSuccessToState(event.user);
    } else if (event is SignInFailure) {
      yield* mapSignInFailureToState(event.message);
    }
  }

  Stream<SignInState> signInEmailAttempt(String email, String password) async* {
    yield SignInLoading();

    User? user = await auth.signIn(email, password);
    if (user != null) {
      add(SignInSuccess(user: user));
    } else {
      add(SignInFailure(
          message: 'Invalid email or password. Please try again.'));
    }
  }

  Stream<SignInState> mapSignInSuccessToState(User user) async* {
    yield LoggedIn(user: user);
  }

  Stream<SignInState> mapSignInFailureToState(String message) async* {
    print(message);
    yield LoggedOut();
  }

}
