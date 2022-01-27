import 'package:pillager/bloc/bloc.dart';

class SignInChange extends VikingEvent with RaidEvent {
  SignInState data;

  SignInChange(this.data);
}