import 'package:equatable/equatable.dart';
import 'package:pillager/models/models.dart';

abstract class DatabaseState extends Equatable {
  final List<Raid> raids;

  const DatabaseState({this.raids = const []});

  @override
  List<Object> get props => [raids];
}

class DatabaseInitial extends DatabaseState {}

class DatabaseLoaded extends DatabaseState {
  const DatabaseLoaded({required raids}) : super(raids: raids);
}

class DatabaseUpdating extends DatabaseState {
  const DatabaseUpdating({required raids}) : super(raids: raids);
}
