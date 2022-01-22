import 'package:pillager/models/models.dart';
import 'package:pillager/bloc/bloc.dart';

abstract class RaidEvent {}

class RaidDataChange extends RaidEvent {
  List<Raid> data;

  RaidDataChange({required this.data});
}

class EditRaid extends RaidEvent {
  final Raid raid;
  final Map<String, Object> update;

  EditRaid(this.raid, this.update);
}

class RaidEditorNoChanges extends RaidEvent {}

class DeleteRaid extends RaidEvent {
  Raid raid;

  DeleteRaid(this.raid);
}

class RaidVikingStateChange extends RaidEvent {
  VikingState data;

  RaidVikingStateChange({required this.data});
}

class AddComment extends RaidEvent {
  Comment comment;
  String raidId;

  AddComment({required this.raidId, required this.comment});
}
