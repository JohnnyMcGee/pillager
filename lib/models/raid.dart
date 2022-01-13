import 'package:equatable/equatable.dart';

import 'package:equatable/equatable.dart';

class Raid extends Equatable {
  String location;
  int numOfShips;
  DateTime arrivalDate;
  List vikings;
  List loot;
  String docId;

  Raid({
    required this.docId,
    required this.location,
    required this.numOfShips,
    required this.arrivalDate,
    required this.vikings,
    required this.loot,
  });

  @override
  List<Object> get props =>
      [docId, location, numOfShips, arrivalDate, vikings, loot];

  @override
  String toString() {
    return '''
    Raid({
      docId: $docId,
      location: $location,
      numOfShips: $numOfShips,
      arrivalDate: $arrivalDate,
      vikings: $vikings,
      loot: $loot
    })
    ''';
  }

  Raid copyWith({
    docId,
    location,
    numOfShips,
    arrivalDate,
    vikings,
    loot,
  }) {
    return Raid(
      docId: docId ?? this.docId,
      location: location ?? this.location,
      numOfShips: numOfShips ?? this.numOfShips,
      arrivalDate: arrivalDate ?? this.arrivalDate,
      vikings: vikings ?? this.vikings,
      loot: loot ?? this.loot,
    );
  }
}