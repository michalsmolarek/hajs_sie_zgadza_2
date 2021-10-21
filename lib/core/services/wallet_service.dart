import 'package:cloud_firestore/cloud_firestore.dart';

class WalletService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  CollectionReference ref;

  WalletService() {
    ref = _db.collection("wallets");
  }

  Future<QuerySnapshot> getDataCollection() {
    return ref.get();
  }

  Stream<QuerySnapshot> streamDataCollection(String id) {
    return ref.doc(id).collection("wallets").snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.doc(id).get();
  }

  Future<void> removeDocument(String id) {
    return ref.doc(id).delete();
  }

  Future<DocumentReference> addDocument(Map data, String id) {
    return ref.doc(id).collection("wallets").add(data);
  }

  Future<void> updateDocument(
      Map<String, dynamic> data, String userId, String walletId) {
    return ref.doc(userId).collection("wallets").doc(walletId).update(data);
  }

  setCurrentWallet(String userId, String walletId) {
    ref.doc(userId).collection("wallets").get().then((snapshot) {
      snapshot.docs.forEach((doc) {
        if (doc.id == walletId) {
          print("set true to $walletId");
          updateDocument({"isCurrent": true}, userId, walletId);
        } else {
          updateDocument({"isCurrent": false}, userId, doc.id);
        }
      });
    });
  }

  getCurrentWallet() {
    ref.where("isCurrent", isEqualTo: true).get().then((snapshot) => {});
  }
}
