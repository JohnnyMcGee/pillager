import 'package:equatable/equatable.dart';

import 'package:equatable/equatable.dart';

class Raid extends Equatable {
  String location;
  int numOfShips;
  DateTime arrivalDate;
  List vikings;
  List loot;

  Raid({
    required this.location,
    required this.numOfShips,
    required this.arrivalDate,
    required this.vikings,
    required this.loot,
  });

  @override
  List<Object> get props => [location, numOfShips, arrivalDate, vikings, loot];

  @override
  String toString() {
    return '''
    {
      location: $location,
      numOfShips: $numOfShips,
      arrivalDate: $arrivalDate,
      vikings: $vikings,
      loot: $loot
    }
    ''';
  }
}
