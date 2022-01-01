import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pillager/services/services.dart';
import './authentication.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {

  AuthenticationBloc() : super(Unauthenticated());

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {

  }

}