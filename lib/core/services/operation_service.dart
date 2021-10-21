import 'package:cloud_firestore/cloud_firestore.dart';

class OperationService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  CollectionReference ref;

  OperationService() {
    ref = _db.collection("operations");
  }

  Future<QuerySnapshot> getDataCollection(String uid) {
    return ref.doc(uid).collection("operations").get();
  }

  Stream<QuerySnapshot> streamDataCollection(String uid) {
    return ref
        .doc(uid)
        .collection("operations")
        .orderBy("date", descending: true)
        .snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.doc(id).get();
  }

  Future<void> removeDocument(String id) {
    return ref.doc(id).delete();
  }

  Future<DocumentReference> addDocument(Map data, String uid) {
    return ref.doc(uid).collection("operations").add(data);
  }

  Future<void> updateDocument(Map data, String id) {
    return ref.doc(id).update(data);
  }
}
