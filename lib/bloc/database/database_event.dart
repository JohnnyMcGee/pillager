import 'package:pillager/models/models.dart';

abstract class DatabaseEvent {
  @override
  List<Object> get props => [];
}

class raidDataChange extends DatabaseEvent {
  List<Raid> data;

  raidDataChange({required this.data}) {print("raidDataChange");}

  @override
  List<Object> get props => [data];
}
