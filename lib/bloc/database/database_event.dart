import 'package:pillager/models/models.dart';

abstract class DatabaseEvent {
  @override
  List<Object> get props => [];
}

class raidDataChange extends DatabaseEvent {
  List<Raid> data;

  raidDataChange({required this.data});
}

class RaidEditorSaveButtonPressed extends DatabaseEvent {
  Map<String, Object?> data;

  RaidEditorSaveButtonPressed({required this.data});
}

class RaidEditorNoChanges extends DatabaseEvent {}

class RaidDeleteButtonPressed extends DatabaseEvent {
  Raid data;

  RaidDeleteButtonPressed({required this.data});
}