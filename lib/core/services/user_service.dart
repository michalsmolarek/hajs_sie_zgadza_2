import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hajs_sie_zgadza_2/core/services/auth_service.dart';
import 'package:hajs_sie_zgadza_2/locator.dart';

class UserService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  CollectionReference ref;

  UserService() {
    ref = _db.collection("users");
  }
  Future<QuerySnapshot> getDataCollection() {
    return ref.get();
  }

  Stream<QuerySnapshot> streamDataCollection() {
    return ref.snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.doc(id).get();
  }

  Future<void> removeDocument(String id) {
    return ref.doc(id).delete();
  }

  Future<DocumentReference> addDocument(Map data, String id) {
    return ref.doc(id).set(data);
  }

  Future<void> updateDocument(Map data, String id) {
    return ref.doc(id).update(data);
  }

  setCurrentWallet(String userId, String walletId) {
    ref.doc(userId).update({"currentWallet": walletId});
  }
}
