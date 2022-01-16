import 'package:pillager/models/models.dart';

abstract class VikingEvent {
  @override
  List<Object> get props => [];
}

class VikingDataChange extends VikingEvent {
  Map<String, Viking> data;

  VikingDataChange({required this.data});
}