import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hajs_sie_zgadza_2/core/models/user.dart';
import 'package:hajs_sie_zgadza_2/core/services/user_service.dart';
import 'package:hajs_sie_zgadza_2/locator.dart';

class UserViewModel extends ChangeNotifier {
  UserService _api = locator<UserService>();

  List<User> list;

  Future<List<User>> fetch() async {
    var result = await _api.getDataCollection();
    list = result.docs.map((doc) => User.fromMap(doc.data(), doc.id)).toList();
    return list;
  }

  Stream<QuerySnapshot> fetchAsStream() {
    return _api.streamDataCollection();
  }

  Future<User> getById(String id) async {
    var doc = await _api.getDocumentById(id);
    return User.fromMap(doc.data(), doc.id);
  }

  Future remove(String id) async {
    await _api.removeDocument(id);
    return;
  }

  Future update(User data, String id) async {
    await _api.updateDocument(data.toJson(), id);
    return;
  }

  Future add(User data) async {
    await _api.addDocument(data.toJson(), data.id);
  }

  setCurrentWallet(String userId, String walletId) {
    _api.setCurrentWallet(userId, walletId);
    notifyListeners();
  }
}
