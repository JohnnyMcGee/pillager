import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class SignInState extends Equatable {
  @override
  List<Object> get props => [];
}

class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {}

class LoggedIn extends SignInState {
  User user;

  LoggedIn({required this.user});
}

class LoggedOut extends SignInState {}
