import 'package:equatable/equatable.dart';

import 'package:equatable/equatable.dart';

class Raid extends Equatable {
  String location;
  int numShips;
  DateTime arrivalDate;
  List<String> vikings;
  List loot;
  String? docId;

  Raid({
    this.docId,
    required this.location,
    required this.numShips,
    required this.arrivalDate,
    required this.vikings,
    required this.loot,
  });

  @override
  List<Object> get props =>
      [location, numShips, arrivalDate, vikings, loot];

  @override
  String toString() {
    return '''
    Raid({
      docId: $docId,
      location: $location,
      numShips: $numShips,
      arrivalDate: $arrivalDate,
      vikings: ${vikings.toString()},
      loot: $loot
    })
    ''';
  }

  Raid copyWith({
    docId,
    location,
    numShips,
    arrivalDate,
    vikings,
    loot,
  }) {
    return Raid(
      docId: docId ?? this.docId,
      location: location ?? this.location,
      numShips: numShips ?? this.numShips,
      arrivalDate: arrivalDate ?? this.arrivalDate,
      vikings: vikings ?? this.vikings,
      loot: loot ?? this.loot,
    );
  }
}