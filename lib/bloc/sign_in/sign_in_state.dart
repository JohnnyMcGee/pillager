import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class SignInState extends Equatable {
  @override
  List<Object> get props => [];
}

class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {}

class SignOutLoading extends SignInState {
  final bool raidStreamClosed;
  final bool vikingStreamClosed;

  SignOutLoading(
      {this.raidStreamClosed=false, this.vikingStreamClosed=false});

  @override
  List<Object> get props => [raidStreamClosed, vikingStreamClosed];
}

class LoggedIn extends SignInState {
  final User user;

  LoggedIn({required this.user});

  @override
  List<Object> get props => [user];
}

class LoggedOut extends SignInState {}
