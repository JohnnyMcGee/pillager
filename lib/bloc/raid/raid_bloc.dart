import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pillager/models/models.dart';

import 'raid.dart';
import 'package:pillager/services/services.dart';
import 'package:pillager/bloc/bloc.dart';

class RaidBloc extends Bloc<RaidEvent, RaidState> {
  final DatabaseService store;

  RaidBloc({required this.store}) : super(RaidInitial()) {
    store.raids.listen((data) {
      add(RaidDataChange(data: data));
    });

    on<RaidDataChange>(_onRaidDataChange);
    on<RaidEditorSaveButtonPressed>(_onRaidEditorSaveButtonPressed);
    on<RaidDeleteButtonPressed>(_onRaidDeleteButtonPressed);
    on<RaidEditorNoChanges>(
        (event, emit) => emit(RaidLoaded(raids: state.raids)));
  }

  void _onRaidDataChange(RaidDataChange event, Emitter emit) {
    emit(RaidLoaded(raids: event.data));
  }

  void _onRaidEditorSaveButtonPressed(
      RaidEditorSaveButtonPressed event, Emitter emit) {
    bool isRaidUpdate = (event.data["docId"] != null && event.data.length > 1);

    // Drop empty form fields
    event.data.removeWhere((k, v) => v == null);

    if (isRaidUpdate) {
      store.updateRaid(event.data);
    } else {
      store.createNewRaid(event.data);
    }

    emit(RaidUpdating(raids: state.raids));
  }

  void _onRaidDeleteButtonPressed(RaidDeleteButtonPressed event, Emitter emit) {
    if (event.data.docId != null) {
      store.deleteRaid(event.data.docId!);
      emit(RaidUpdating(raids: state.raids));
    }
  }
}
