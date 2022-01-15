import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pillager/models/models.dart';

import './vikings.dart';
import 'package:pillager/services/services.dart';
import 'package:pillager/bloc/bloc.dart';

class VikingsBloc extends Bloc<VikingsEvent, VikingsState> {
  final DatabaseService store;

  VikingsBloc({required this.store}) : super(VikingsInitial()) {
    store.vikings.listen((data) {
      add(VikingDataChange(data: data));
    });
    on<VikingDataChange>(_onVikingDataChange);
  }

  void _onVikingDataChange(VikingDataChange event, Emitter emit) {
    event.data.forEach((v) => print(v.toString()));
    emit(VikingsLoaded(vikings: state.vikings));
  }
}
