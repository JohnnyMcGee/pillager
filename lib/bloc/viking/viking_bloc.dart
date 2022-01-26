import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pillager/models/models.dart';

import 'package:pillager/services/services.dart';
import 'package:pillager/bloc/bloc.dart';

class VikingBloc extends Bloc<VikingEvent, VikingState> {
  final DatabaseService store;
  final SignInBloc signInBloc;
  late final StreamSubscription _signInListener;
  final List<StreamSubscription> _vikingListeners = <StreamSubscription>[];

  VikingBloc({required this.store, required this.signInBloc})
      : super(VikingInitial()) {
    final _vikingListener =
        store.vikings.listen((data) => add(VikingDataChange(data)));
    _vikingListeners.add(_vikingListener);
    _signInListener =
        signInBloc.stream.listen((state) => add(SignInChange(state)));

    on<VikingDataChange>(_onVikingDataChange);
    on<UpdateViking>(_onUpdateViking);
    on<SignInChange>(_onSignInChange);
  }

  void _onVikingDataChange(VikingDataChange event, Emitter emit) {
    emit(VikingLoaded(vikings: event.data));
  }

  void _onUpdateViking(UpdateViking event, Emitter emit) {
    if (event.update.isNotEmpty) {
      store.updateViking(event.viking, event.update);
      emit(VikingUpdating(vikings: state.vikings));
    }
  }

  void _onSignInChange(SignInChange event, Emitter emit) async {
    if (event.data is LoggedIn) {
      final _vikingListener =
          store.vikings.listen((data) => add(VikingDataChange(data)));
      _vikingListeners.add(_vikingListener);
    } else if (event.data is SignOutLoading) {
      _vikingListeners.forEach((sub) async {
        await sub.cancel();
      });
      signInBloc.add(StreamClosed(vikingStreamClosed: true));
    }
    emit(const VikingUpdating(vikings: <String, Viking>{}));
  }

  @override
  Future<void> close() async {
    _signInListener.cancel();
    _vikingListeners.forEach((sub) {
      sub.cancel();
    });
    super.close();
  }
}
