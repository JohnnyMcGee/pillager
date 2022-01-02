import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pillager/models/models.dart';

class DatabaseService {
  // raids collection reference
  final CollectionReference raidsCollection =
      FirebaseFirestore.instance.collection('raids');

  // get raids stream
  Stream<List<Raid>> get raids {
    return raidsCollection.snapshots().map((ss) {print('reload'); return _raidsFromSnapshot(ss);});
  }

  // add new raid

  // update existing raid

  // delete existing raid

  // list of raids from snapshot
  List<Raid> _raidsFromSnapshot(QuerySnapshot snapshot) {
    // snapshot.docs.forEach((doc) {
    //   print(doc.get('location'));
    //   print(doc.get('numShips'));
    //   print(doc.get('arrivalDate'));
    //   print(doc.get('vikings'));
    //   print(doc.get('loot'));
    // });
    return snapshot.docs
        .map((doc) => Raid(
              location: doc.get('location'),
              numOfShips: doc.get('numShips'),
              arrivalDate: doc.get('arrivalDate').toDate(),
              vikings: doc.get('vikings'),
              loot: doc.get('loot'),
            ))
        .toList();
  }

  // raid from snapshot

}
