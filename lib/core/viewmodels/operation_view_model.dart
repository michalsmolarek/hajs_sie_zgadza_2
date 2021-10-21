import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hajs_sie_zgadza_2/core/models/operation.dart';
import 'package:hajs_sie_zgadza_2/core/models/user.dart';
import 'package:hajs_sie_zgadza_2/core/services/operation_service.dart';
import 'package:hajs_sie_zgadza_2/locator.dart';

class OperationViewModel extends ChangeNotifier {
  OperationService _api = locator<OperationService>();

  List<Operation> list;

  // TODO: Przerobić, aby było tak: operations->wallet->operations
  // TODO: Ewentualnie operations -> uid -> operations

  Future<List<Operation>> fetch(String uid) async {
    var result = await _api.getDataCollection(uid);
    list = result.docs
        .map((doc) => Operation.fromMap(doc.data(), doc.id))
        .toList();
    return list;
  }

  Stream<QuerySnapshot> fetchAsStream(String uid) {
    return _api.streamDataCollection(uid);
  }

  Future<Operation> getById(String id) async {
    var doc = await _api.getDocumentById(id);
    return Operation.fromMap(doc.data(), doc.id);
  }

  Future remove(String id) async {
    await _api.removeDocument(id);
    return;
  }

  Future update(Operation data, String id) async {
    await _api.updateDocument(data.toJson(), id);
    return;
  }

  Future add(Operation data, String uid) async {
    return await _api.addDocument(data.toJson(), uid);
  }
}
