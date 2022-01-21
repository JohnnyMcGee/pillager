import 'package:pillager/models/models.dart';
import 'package:pillager/bloc/bloc.dart';

abstract class RaidEvent {}

class RaidDataChange extends RaidEvent {
  List<Raid> data;

  RaidDataChange({required this.data});
}

class EditRaid extends RaidEvent {
  List<Raid> data;
  EditRaid(this.data) {
    // data must contain a raid and corresponding "updated" raid
    assert(data.length == 2);
    assert(data[0].docId == data[1].docId);
  }
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
