import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pillager/models/models.dart';

import 'raid.dart';
import 'package:pillager/services/services.dart';
import 'package:pillager/bloc/bloc.dart';

class RaidBloc extends Bloc<RaidEvent, RaidState> {
  final DatabaseService store;
  final VikingBloc vikingBloc;

  RaidBloc({required this.store, required this.vikingBloc})
      : super(RaidInitial()) {
    store.raids.listen((data) {
      add(RaidDataChange(data: data));
    });

    vikingBloc.stream.listen((vikingState) {
      add(RaidVikingStateChange(data: vikingState));
    });

    on<RaidDataChange>(_onRaidDataChange);
    on<RaidEditorSaveButtonPressed>(_onRaidEditorSaveButtonPressed);
    on<RaidDeleteButtonPressed>(_onRaidDeleteButtonPressed);
    on<RaidEditorNoChanges>(
        (event, emit) => emit(RaidLoaded(raids: state.raids)));
    on<RaidVikingStateChange>(_onRaidVikingStateChange);
  }

  void _onRaidDataChange(RaidDataChange event, Emitter emit) {
    List<Raid> raids;

    if (vikingBloc.state is VikingLoaded) {
      raids = event.data
          .map((raid) => store.raidLoadVikings(raid, vikingBloc.state.vikings))
          .toList();
    } else {
      raids = event.data;
    }

    emit(RaidLoaded(raids: raids));
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

  void _onRaidVikingStateChange(RaidVikingStateChange event, Emitter emit) {
    if (event.data is VikingLoaded && state is RaidLoaded) {
      final List<Raid> raids = state.raids
          .map((raid) => store.raidLoadVikings(raid, event.data.vikings))
          .toList();
      emit(RaidLoaded(raids: raids));
    }
  }
}
