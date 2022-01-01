import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {

  @override
  List<Object> get props => [];

}

class AuthenticationUninitialized extends AuthenticationState {

  AuthenticationUninitialized();
}

