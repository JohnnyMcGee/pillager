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
    on<UserStateChange>(_onUserStateChange);
    on<DeleteAccount>(_onDeleteAccount);
    on<SignOutButtonPressed>(_onSignOutButtonPressed);
    on<RaidStreamClosed>(_onRaidStreamClosed);
    on<VikingStreamClosed>(_onVikingStreamClosed);
    on<SignInSuccess>((event, emit) => emit(LoggedIn(user: event.user)));
    on<SignInFailure>((event, emit) => emit(LoggedOut()));
  }

  void _onSignInEmailButtonPressed(
      SignInEmailButtonPressed event, Emitter<SignInState> emit) async {
    auth.signIn(event.email, event.password).then((user) {
      if (user is User) {
        add(SignInSuccess(user: user));
      } else {
        add(SignInFailure(message: "Couldn't sign in."));
      }
    });
    emit(SignInLoading());
  }

  void _onRegisterEmailButtonPressed(
      RegisterEmailButtonPressed event, Emitter<SignInState> emit) async {
    String capitalize(String s) =>
        (s.isNotEmpty) ? s[0].toUpperCase() + s.substring(1) : s;

    final String first = capitalize(event.firstName);
    final String last = capitalize(event.lastName);

    auth
        .registerWithEmailAndPassword(event.email, event.password, first, last)
        .then((user) => store
            .createNewViking(user.uid, {"firstName": first, "lastName": last}));

    emit(SignInLoading());
  }

  void _onSignOutButtonPressed(SignOutButtonPressed event, Emitter emit) {
    // Allow firestore subscriptions to close before signing out
    emit(SignOutLoading(raidStreamClosed: false, vikingStreamClosed: false));
  }

  void _onRaidStreamClosed(RaidStreamClosed event, Emitter emit) {
    if (state is SignOutLoading) {
      if ((state as SignOutLoading).vikingStreamClosed) {
        emit(LoggedOut());
      } else {
        emit(SignOutLoading(raidStreamClosed: true));
      }
    }
  }

  void _onVikingStreamClosed(VikingStreamClosed event, Emitter emit) {
    if (state is SignOutLoading) {
      if ((state as SignOutLoading).raidStreamClosed) {
        emit(LoggedOut());
      } else {
        emit(SignOutLoading(vikingStreamClosed: true));
      }
    }
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
