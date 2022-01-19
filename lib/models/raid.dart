import 'package:equatable/equatable.dart';
import 'package:pillager/models/models.dart';
import 'package:intl/intl.dart';

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

  static Raid newRaid = Raid(
        location: "New Raid",
        numShips: 1,
        arrivalDate: DateTime.now(),
        vikings: const <String, Object>{},
        loot: const [],
      );

  @override
  List<Object> get props => [location, numShips, arrivalDate, vikings, loot];

  @override
  String toString() {
    return 'Raid({$docId, $location})';
  }

  String get arrivalDateFormatted => DateFormat.yMd().format(arrivalDate);

  List<String> get vikingNameList {
    return [
      for (var v in vikings.values)
        (v is Viking) ? v.fullName : ''
    ];
  }

  String get vikingNames => vikingNameList.join(', ');
  
  String get vikingNamesShort {
    List<String> names = vikingNameList;

    if (names.length > 2) {
      return '${names[0]}, ${names[1]}, ${names.length - 2} others';
    }
    return vikingNames;
  }

  // @override
  // String toString() {
  //   return '''
  //   Raid({
  //     docId: $docId,
  //     location: $location,
  //     numShips: $numShips,
  //     arrivalDate: $arrivalDate,
  //     vikings: ${vikings.toString()},
  //     loot: $loot
  //   })
  //   ''';
  // }

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
