import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './database.dart';
import 'package:pillager/services/services.dart';
import 'package:pillager/bloc/bloc.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  final DatabaseService store;

  DatabaseBloc({required this.store}) : super(DatabaseInitial()) {
    store.raids.listen((data) {add(raidDataChange(data: data));});

    on<raidDataChange>(_onRaidDataChange);
    
  }

  void _onRaidDataChange(raidDataChange event, Emitter emit) {
    emit(DatabaseLoaded(raids: event.data));
  }


}
