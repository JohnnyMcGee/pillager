import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './database.dart';
import 'package:pillager/services/services.dart';
import 'package:pillager/bloc/bloc.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  final DatabaseService store;

  DatabaseBloc({required this.store}) : super(DatabaseInitial()) {
    store.raids.listen((data) {
      add(raidDataChange(data: data));
    });

    on<raidDataChange>(_onRaidDataChange);
    on<RaidEditorSaveButtonPressed>(_onraidEditorSaveButtonPressed);
    on<RaidEditorNoChanges>(
        (event, emit) => emit(DatabaseLoaded(raids: state.raids)));
  }

  void _onRaidDataChange(raidDataChange event, Emitter emit) {
    emit(DatabaseLoaded(raids: event.data));
  }

  void _onraidEditorSaveButtonPressed(
      RaidEditorSaveButtonPressed event, Emitter emit) {
    bool isRaidUpdate = (event.data["docId"] != null && event.data.length > 1);

    // Drop empty form fields
    event.data.removeWhere((k, v) => v == null);

    if (isRaidUpdate) {
      store.updateRaid(event.data);
    } else {
      store.createNewRaid(event.data);
    }

    emit(DatabaseUpdating(raids: state.raids));
  }
}
