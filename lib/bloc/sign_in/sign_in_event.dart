import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class SignInEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignInEmailButtonPressed extends SignInEvent {
  final String email;
  final String password;

  SignInEmailButtonPressed({required this.email, required this.password});
}

class RegisterEmailButtonPressed extends SignInEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String confirmPassword;

  RegisterEmailButtonPressed({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}

class SignOutButtonPressed extends SignInEvent {}

class SignOutSuccess extends SignInEvent {}

class SignInSuccess extends SignInEvent {
  final User user;

  SignInSuccess({required this.user});
}

class SignInFailure extends SignInEvent {
  final String message;

  SignInFailure({required this.message});
}

class UserStateChange extends SignInEvent {
  final User? user;

  UserStateChange(this.user);
}

class DeleteAccount extends SignInEvent {
  final String password;
  DeleteAccount(String this.password);

  @override
  List<Object> get props => [password];
}

class RaidStreamClosed extends SignInEvent {}

class VikingStreamClosed extends SignInEvent {}
