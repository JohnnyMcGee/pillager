import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pillager/models/models.dart';

class DatabaseService {
  final CollectionReference raidsCollection =
      FirebaseFirestore.instance.collection('raids');

  final CollectionReference vikingsCollection =
      FirebaseFirestore.instance.collection('vikings');

  final CollectionReference commentsCollection =
      FirebaseFirestore.instance.collection('comments');

  Stream<List<Raid>> get raids {
    return raidsCollection.snapshots().map(_raidsFromSnapshot);
  }

  Stream<Map<String, Viking>> get vikings {
    return vikingsCollection.snapshots().map(_vikingsFromSnapshot);
  }

  Stream<List<Comment>> getComments(String docId) {
    return commentsCollection.doc(docId).snapshots().map(_commentsFromSnapshot);
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
          comments: [for (var map in doc.get('comments')) Comment.fromMap(map)],
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
      changes["vikings"] = List.from(update.vikings.keys);
    }
    if (raid.comments != update.comments) {
      changes["comments"] = [for (var c in update.comments) c.toMap()];
    }
    return changes;
  }

  void updateRaid(Raid raid, Raid update) {
    if (update.docId == null) {
      createNewRaid(update);
    } else {
      final Map<String, Object> changes = _compareRaids(raid, update);
      final DocumentReference raidDoc =
          raidsCollection.doc(update.docId as String);
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
        "vikings": List.from(raid.vikings.keys),
        "comments": [for (var c in raid.comments) c.toMap()],
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

  void createNewViking(String uid, Map<String, Object> data) {
    try {
      vikingsCollection
          .doc(uid)
          .set(data..addAll({"isBerserker": false, "isEarl": false}));
    } catch (e) {
      print(e);
    }
  }

  void updateViking(Viking viking, Map<String, Object> update) {
    final doc = vikingsCollection.doc(viking.uid);
    final data = Map<String, Object>.from(update)
      ..removeWhere((k, v) =>
          !["firstName", "lastName", "isBerserker", "isEarl"].contains(k));
    doc.update(data);
  }

  List<Comment> _commentsFromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.get("comments");
    if (data is Iterable) {
      return [for (var comment in data) Comment.fromMap(comment)];
    } else {
      return <Comment>[Comment(sender:"", timeStamp: DateTime.now(), message: "${data.runtimeType}")];
    }
  }
    void updateComments(String docId, List<Comment> update) {
    final doc = commentsCollection.doc(docId);
    final data = update.map((comment) => comment.toMap());
    doc.update({"comments": data});
  }
  
}
