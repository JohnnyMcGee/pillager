import 'package:equatable/equatable.dart';
import 'package:pillager/models/models.dart';

abstract class VikingsState extends Equatable {
  final List<Raid> vikings;

  const VikingsState({this.vikings = const []});

  @override
  List<Object> get props => [vikings];
}

class VikingsInitial extends VikingsState {}

class VikingsLoaded extends VikingsState {
  const VikingsLoaded({required vikings}) : super(vikings: vikings);
}

class VikingsUpdating extends VikingsState {
  const VikingsUpdating({required vikings}) : super(vikings: vikings);
}
