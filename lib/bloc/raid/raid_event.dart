import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pillager/models/models.dart';

abstract class RaidEvent {
  @override
  List<Object> get props => [];
}

class RaidDataChange extends RaidEvent {
  QuerySnapshot<Object?> data;

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