import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pillager/models/models.dart';

class DatabaseService {
  // raids collection reference
  final CollectionReference raidsCollection =
      FirebaseFirestore.instance.collection('raids');

  // get raids stream
  Stream<List<Raid>> get raids {
    return raidsCollection.snapshots().map(_raidsFromSnapshot);
  }

  // add new raid

  // update existing raid

  // delete existing raid

  // list of raids from snapshot
  List<Raid> _raidsFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) => Raid(
              docId: doc.id,
              location: doc.get('location'),
              numShips: doc.get('numShips'),
              arrivalDate: doc.get('arrivalDate').toDate(),
              vikings: doc.get('vikings'),
              loot: doc.get('loot'),
            ))
        .toList();
  }

  void updateRaid(Map<String, Object?> data) {
    final raidDoc = raidsCollection.doc(data["docId"] as String);
    data.removeWhere((k,v) => k=="docId");
    try {
      raidDoc.update(data);
    } catch (e) {
      print(e);
    }
  }

  // raid from snapshot

}
