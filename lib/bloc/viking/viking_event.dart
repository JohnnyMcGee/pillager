import 'package:pillager/models/models.dart';

abstract class VikingEvent {}

class VikingDataChange extends VikingEvent {
  Map<String, Viking> data;

  VikingDataChange(this.data);
}

class UpdateViking extends VikingEvent {
  Viking viking;
  Map<String, Object> update;

  UpdateViking({required this.viking, required this.update});
}