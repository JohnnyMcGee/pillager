import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pillager/models/models.dart';

class DatabaseService {
  final CollectionReference raidsCollection =
      FirebaseFirestore.instance.collection('raids');

  final CollectionReference vikingsCollection =
      FirebaseFirestore.instance.collection('vikings');

  Stream<List<Raid>> get raids {
    return raidsCollection.snapshots().map(_raidsFromSnapshot);
  }

  Stream<Map<String, Viking>> get vikings {
    return vikingsCollection.snapshots().map(_vikingsFromSnapshot);
  }

  List<Raid> _raidsFromSnapshot(QuerySnapshot snapshot) {
    return [
      for (var doc in snapshot.docs)
        Raid(
          docId: doc.id,
          location: doc.get('location'),
          numShips: doc.get('numShips'),
          arrivalDate: doc.get('arrivalDate').toDate(),
          // Initialize vikings with dummy value -1
          // Values added later using raidLoadVikings method
          vikings: {for (var id in doc.get('vikings')) id: -1},
          loot: doc.get('loot'),
        )
    ];
  }

  Map<String, Object> _compareRaids(raid, update) {
    var changes = <String, Object>{};
    if (raid.location != update.location) {
      changes["location"] = update.location;
    }
    if (raid.numShips != update.numShips) {
      changes["numShips"] = update.numShips;
    }
    if (raid.arrivalDate != update.arrivalDate) {
      changes["arrivalDate"] = update.arrivalDate;
    }
    if (raid.vikings != update.vikings) {
      changes["vikings"] = update.vikings;
    }
    if (raid.loot != update.loot) {
      changes["loot"] = update.loot;
    }
    return changes;
  }

  void updateRaid(Raid raid, Raid update) {
    if (update.docId == null) {
      createNewRaid(update);
    } else {
      final Map<String, Object> changes = _compareRaids(raid, update);
      final DocumentReference raidDoc = raidsCollection.doc(update.docId as String);
      try {
        raidDoc.update(changes);
      } catch (e) {
        print(e);
      }
    }
  }

  void createNewRaid(Raid raid) {
    try {
      raidsCollection.add({
        "location": raid.location,
        "numShips": raid.numShips,
        "arrivalDate": raid.arrivalDate,
        "vikings": List.from(raid.vikings.values),
        "loot": [],
      });
    } catch (e) {
      print(e);
    }
  }

  void deleteRaid(String docId) {
    try {
      final raidDoc = raidsCollection.doc(docId);
      raidDoc.delete();
    } catch (e) {
      print(e);
    }
  }

  Map<String, Viking> _vikingsFromSnapshot(QuerySnapshot snapshot) {
    return {
      for (var doc in snapshot.docs)
        doc.id: Viking(
          uid: doc.id,
          firstName: doc.get("firstName"),
          lastName: doc.get("lastName"),
          isBerserker: doc.get("isBerserker"),
          isEarl: doc.get("isEarl"),
        )
    };
  }

  Raid raidLoadVikings(Raid raid, Map<String, Viking> vikings) {
    Map<String, Object> raidVikings = Map<String, Object>.from(raid.vikings.map(
        (k, v) => MapEntry<String, Object>(
            k, (vikings.containsKey(k) ? vikings[k] : -2)!)));
    return raid.copyWith(vikings: raidVikings);
  }
}
