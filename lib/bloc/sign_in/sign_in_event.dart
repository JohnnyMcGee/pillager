import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class SignInEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignInEmailButtonPressed extends SignInEvent {
  String email;
  String password;

  SignInEmailButtonPressed({required this.email, required this.password});

}

class RegisterEmailButtonPressed extends SignInEvent {
  String firstName;
  String lastName;
  String email;
  String password;
  String confirmPassword;

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
  User user;

  SignInSuccess({required this.user});
  
}

class SignInFailure extends SignInEvent {
  String message;

  SignInFailure({required this.message});
  
}