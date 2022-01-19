import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pillager/services/services.dart';
import 'package:pillager/bloc/bloc.dart';

class VikingBloc extends Bloc<VikingEvent, VikingState> {
  final DatabaseService store;
  final User user;

  VikingBloc({required this.store, required this.user})
      : super(VikingInitial()) {
    store.vikings.listen((data) {
      add(VikingDataChange(data));
    });

    on<VikingDataChange>(_onVikingDataChange);
  }

  void _onVikingDataChange(VikingDataChange event, Emitter emit) {
    emit(VikingLoaded(vikings: event.data));
  }

}
