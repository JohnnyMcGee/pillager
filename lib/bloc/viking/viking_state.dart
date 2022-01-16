import 'package:equatable/equatable.dart';
import 'package:pillager/models/models.dart';

abstract class VikingState extends Equatable {
  final Map<String, Viking> vikings;

  VikingState({required this.vikings});
}

class VikingInitial extends VikingState {
  VikingInitial() : super(vikings: {});

  @override
  List<Object?> get props => [vikings];
}

class VikingLoaded extends VikingState {
  VikingLoaded({required vikings}) : super(vikings: vikings);

  @override
  List<Object?> get props => [vikings];
}

class VikingUpdating extends VikingState {
  VikingUpdating({required vikings}) : super(vikings: vikings);

  @override
  List<Object?> get props => [vikings];
}