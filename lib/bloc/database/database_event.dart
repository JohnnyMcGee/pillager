import 'package:pillager/models/models.dart';

abstract class DatabaseEvent {
  @override
  List<Object> get props => [];
}

class raidDataChange extends DatabaseEvent {
  List<Raid> data;

  raidDataChange({required this.data});

  @override
  List<Object> get props => [data];
}

class RaidEditorSaveButtonPressed extends DatabaseEvent {
  Map<String, Object?> data;

  RaidEditorSaveButtonPressed({required this.data});

  @override
  List<Object> get props => [data];
}
