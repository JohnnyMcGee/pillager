import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pillager/services/services.dart';
import 'package:pillager/bloc/bloc.dart';

class VikingBloc extends Bloc<VikingEvent, VikingState> {
  final DatabaseService store;
  final SignInBloc signInBloc;

  VikingBloc({required this.store, required this.signInBloc})
      : super(VikingInitial()) {
    signInBloc.stream.listen((signInState) => add(SignInChange(signInState)));

    on<SignInChange>(_onSignInChange);
    on<VikingDataChange>(_onVikingDataChange);
    on<UpdateViking>(_onUpdateViking);
  }

  void _onVikingDataChange(VikingDataChange event, Emitter emit) {
    emit(VikingLoaded(vikings: event.data));
  }

  void _onSignInChange(SignInChange event, Emitter emit) {
    if (event.data is LoggedIn) {
      store.vikings.listen((data) {
        add(VikingDataChange(data));
      });

      emit(VikingUpdating(vikings: state.vikings));
    }
  }

  void _onUpdateViking(UpdateViking event, Emitter emit) {
    store.updateViking(event.viking, event.update);
    emit(VikingUpdating(vikings: state.vikings));
  }
  
}
