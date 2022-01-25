import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pillager/services/services.dart';
import 'package:pillager/bloc/bloc.dart';

class VikingBloc extends Bloc<VikingEvent, VikingState> {
  final DatabaseService store;
  final SignInBloc signInBloc;
  late final StreamSubscription _vikingListener;

  VikingBloc({required this.store, required this.signInBloc})
      : super(VikingInitial()) {
    _vikingListener = store.vikings.listen((data) => add(VikingDataChange(data)));

    on<VikingDataChange>(_onVikingDataChange);
    on<UpdateViking>(_onUpdateViking);
  } 

  void _onVikingDataChange(VikingDataChange event, Emitter emit) {
    emit(VikingLoaded(vikings: event.data));
  }

  void _onUpdateViking(UpdateViking event, Emitter emit) {
    if (event.update.isNotEmpty)
    {
    store.updateViking(event.viking, event.update);
    emit(VikingUpdating(vikings: state.vikings));
    }
  }

  @override
  Future<void> close() async {
    _vikingListener.cancel();
    super.close();
  }

}
