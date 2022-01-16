import 'package:equatable/equatable.dart';

class Raid extends Equatable {
  final String location;
  final int numShips;
  final DateTime arrivalDate;
  final Map<String, Object> vikings;
  final List loot;
  final String? docId;

  const Raid({
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
    String? docId,
    String? location,
    int? numShips,
    DateTime? arrivalDate,
    Map<String, Object>? vikings,
    List? loot,
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