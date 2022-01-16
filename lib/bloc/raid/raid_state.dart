import 'package:equatable/equatable.dart';
import 'package:pillager/models/models.dart';

abstract class RaidState extends Equatable {
  final List<Raid> raids;

  const RaidState({this.raids = const []});

  @override
  List<Object> get props => [raids];
}

class RaidInitial extends RaidState {}

class RaidLoaded extends RaidState {
  const RaidLoaded({required raids}) : super(raids: raids);
}

class RaidUpdating extends RaidState {
  const RaidUpdating({required raids}) : super(raids: raids);
}
