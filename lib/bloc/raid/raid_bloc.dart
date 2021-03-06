import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pillager/models/models.dart';

import 'package:pillager/services/services.dart';
import 'package:pillager/bloc/bloc.dart';

class RaidBloc extends Bloc<RaidEvent, RaidState> {
  final DatabaseService store;
  final VikingBloc vikingBloc;
  final SignInBloc signInBloc;
  late final StreamSubscription _signInBlocListener;
  late StreamSubscription _vikingBlocListener;
  final List<StreamSubscription> _raidListeners = <StreamSubscription>[];

  RaidBloc(
      {required this.store, required this.vikingBloc, required this.signInBloc})
      : super(RaidInitial()) {
    _signInBlocListener = signInBloc.stream.listen((state) {
      if (state is LoggedIn || state is SignOutLoading) {
        add(SignInChange(state));
      }
    });

    _addListeners();

    on<RaidDataChange>(_onRaidDataChange);
    on<EditRaid>(_onEditRaid);
    on<DeleteRaid>(_onRaidDeleteButtonPressed);
    on<RaidEditorNoChanges>(
        (event, emit) => emit(RaidLoaded(raids: state.raids)));
    on<RaidVikingStateChange>(_onRaidVikingStateChange);

    on<SignInChange>(_onSignInChange);
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
    if (event.update.isNotEmpty) {
      if (event.raid.docId.isEmpty) {
        store.createNewRaid(event.raid, event.update);
      } else {
        store.updateRaid(event.raid, event.update);
      }

      emit(RaidUpdating(raids: state.raids));
    }
  }

  void _onRaidDeleteButtonPressed(DeleteRaid event, Emitter emit) {
    if (event.raid.docId.isNotEmpty) {
      store.deleteRaid(event.raid.docId);
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

  void _onSignInChange(SignInChange event, Emitter emit) async {
    if (event.data is LoggedIn) {
      _cancelDataListeners();
      _addListeners();
    } else if (event.data is SignOutLoading && state is RaidLoaded) {
      _cancelDataListeners();
      signInBloc.add(RaidStreamClosed());
    }
    emit(const RaidUpdating(raids: <Raid>[]));
  }

  void _addListeners() {
    final _raidListener = store.raids.listen((data) {
      add(RaidDataChange(data: data));
    });

    _raidListeners.add(_raidListener);

    _vikingBlocListener = vikingBloc.stream.listen((vikingState) {
      add(RaidVikingStateChange(data: vikingState));
    });
  }

  void _cancelDataListeners() {
    cancelSub(StreamSubscription sub) async => await sub.cancel();
    _raidListeners.forEach(cancelSub);
    _vikingBlocListener.cancel();
  }

  @override
  Future<void> close() async {
    _signInBlocListener.cancel();
    _cancelDataListeners();
    super.close();
  }
}
