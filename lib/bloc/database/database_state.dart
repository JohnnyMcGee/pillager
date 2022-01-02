import 'package:equatable/equatable.dart';
import 'package:pillager/models/models.dart';

abstract class DatabaseState extends Equatable {
  List<Raid> raids;

  DatabaseState({this.raids = const []});

  @override
  List<Object> get props => [raids];
}

class DatabaseInitial extends DatabaseState {}

class DatabaseLoaded extends DatabaseState {
  DatabaseLoaded({required raids}) : super(raids: raids);
}
