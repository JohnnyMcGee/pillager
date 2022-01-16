import 'package:pillager/models/models.dart';

abstract class VikingEvent {}

class VikingDataChange extends VikingEvent {
  Map<String, Viking> data;

  VikingDataChange({required this.data});
}