import 'package:equatable/equatable.dart';
import 'package:pillager/models/models.dart';

abstract class VikingState extends Equatable {
  final Map<String, Viking> vikings;

  const VikingState({required this.vikings});
}

class VikingInitial extends VikingState {
  VikingInitial() : super(vikings: {});

  @override
  List<Object?> get props => [vikings];
}

class VikingLoaded extends VikingState {
  const VikingLoaded({required vikings}) : super(vikings: vikings);

  @override
  List<Object?> get props => [vikings];
}

class VikingUpdating extends VikingState {
  const VikingUpdating({required vikings}) : super(vikings: vikings);

  @override
  List<Object?> get props => [vikings];
}