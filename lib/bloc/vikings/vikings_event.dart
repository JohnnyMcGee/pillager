import 'package:pillager/models/models.dart';

abstract class VikingsEvent {
  @override
  List<Object> get props => [];
}

class VikingDataChange extends VikingsEvent {
  List<Viking> data;

  VikingDataChange({required this.data});
}