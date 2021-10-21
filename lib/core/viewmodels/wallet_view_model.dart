import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hajs_sie_zgadza_2/core/models/wallet.dart';

import 'package:hajs_sie_zgadza_2/core/services/wallet_service.dart';
import 'package:hajs_sie_zgadza_2/locator.dart';

class WalletViewModel extends ChangeNotifier {
  WalletService _api = locator<WalletService>();

  List<Wallet> list;

  Future<List<Wallet>> fetch() async {
    var result = await _api.getDataCollection();
    list =
        result.docs.map((doc) => Wallet.fromMap(doc.data(), doc.id)).toList();
    return list;
  }

  Stream<QuerySnapshot> fetchAsStream(String userId) {
    return _api.streamDataCollection(userId);
  }

  Future<Wallet> getById(String id) async {
    var doc = await _api.getDocumentById(id);
    return Wallet.fromMap(doc.data(), doc.id);
  }

  Future remove(String id) async {
    await _api.removeDocument(id);
    return;
  }

  Future update(Wallet data, String userId, String walletId) async {
    await _api.updateDocument(data.toJson(), userId, walletId);
    return;
  }

  Future add(Wallet data, String userId) async {
    return await _api.addDocument(data.toJson(), userId);
  }

  setCurrentWallet(String walletId, String userId) {
    _api.setCurrentWallet(userId, walletId);
    notifyListeners();
  }
}
