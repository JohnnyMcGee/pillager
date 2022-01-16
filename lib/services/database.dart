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
    return snapshot.docs
        .map((doc) => Raid(
              docId: doc.id,
              location: doc.get('location'),
              numShips: doc.get('numShips'),
              arrivalDate: doc.get('arrivalDate').toDate(),
              // Initialize vikings with just keys
              // Values added later using raidLoadVikings method
              vikings: Map<String, Object>.fromIterable(doc.get('vikings'),
                  key: (id) => id, value: (id) => -1),
              loot: doc.get('loot'),
            ))
        .toList();
  }

  void updateRaid(Map<String, Object?> data) {
    final raidDoc = raidsCollection.doc(data["docId"] as String);
    data.removeWhere((k, v) => k == "docId");
    try {
      raidDoc.update(data);
    } catch (e) {
      print(e);
    }
  }

  void createNewRaid(Map<String, Object?> data) {
    try {
      raidsCollection.add({
        "location":
            data.containsKey("location") ? data["location"] : "New Raid",
        "numShips": data.containsKey("numShips") ? data["numShips"] : 1,
        "arrivalDate": data.containsKey("arrivalDate")
            ? data["arrivalDate"]
            : DateTime.now(),
        "vikings": data.containsKey("vikings") ? data["vikings"] : [],
        "loot": data.containsKey("loot") ? data["loot"] : [],
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
    return Map.fromIterable(
      snapshot.docs,
      key: (doc) => doc.id,
      value: (doc) => Viking(
        uid: doc.id,
        firstName: doc.get("firstName"),
        lastName: doc.get("lastName"),
        isBerserker: doc.get("isBerserker"),
        isEarl: doc.get("isEarl"),
      ),
    );
  }

  Raid raidLoadVikings(Raid raid, List<Viking> vikings) {
    return raid;
  }
  
}
