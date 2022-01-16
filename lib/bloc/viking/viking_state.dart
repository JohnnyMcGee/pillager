import 'package:equatable/equatable.dart';
import 'package:pillager/models/models.dart';

abstract class VikingState extends Equatable {
  final List<Raid> vikings;

  const VikingState({this.vikings = const []});

  @override
  List<Object> get props => [vikings];
}

class VikingInitial extends VikingState {}

class VikingLoaded extends VikingState {
  const VikingLoaded({required vikings}) : super(vikings: vikings);
}

class VikingUpdating extends VikingState {
  const VikingUpdating({required vikings}) : super(vikings: vikings);
}
