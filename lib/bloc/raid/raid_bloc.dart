import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pillager/models/models.dart';

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
    on<EditRaid>(_onEditRaid);
    on<DeleteRaid>(_onRaidDeleteButtonPressed);
    on<RaidEditorNoChanges>(
        (event, emit) => emit(RaidLoaded(raids: state.raids)));
    on<RaidVikingStateChange>(_onRaidVikingStateChange);
    on<AddComment>(_onAddComment);
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

  void _onEditRaid(EditRaid event, Emitter emit) {
    store.updateRaid(event.data[0], event.data[1]);

    emit(RaidUpdating(raids: state.raids));
  }

  void _onRaidDeleteButtonPressed(DeleteRaid event, Emitter emit) {
    if (event.raid.docId != null) {
      store.deleteRaid(event.raid.docId!);
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

  void _onAddComment(AddComment event, Emitter emit) {
    
  }


  
}
