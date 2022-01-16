import 'package:pillager/models/models.dart';
import 'package:pillager/bloc/bloc.dart';

abstract class RaidEvent {}

class RaidDataChange extends RaidEvent {
  List<Raid> data;

  RaidDataChange({required this.data});
}

class RaidEditorSaveButtonPressed extends RaidEvent {
  Map<String, Object?> data;

  RaidEditorSaveButtonPressed({required this.data});
}

class RaidEditorNoChanges extends RaidEvent {}

class RaidDeleteButtonPressed extends RaidEvent {
  Raid data;

  RaidDeleteButtonPressed({required this.data});
}

class RaidVikingStateChange extends RaidEvent {
  VikingState data;

  RaidVikingStateChange({required this.data});
}
