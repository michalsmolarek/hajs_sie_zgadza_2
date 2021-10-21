import 'package:cloud_firestore/cloud_firestore.dart';

class Operation {
  String id;
  String title;
  double amount;
  bool isContribution;
  Timestamp date;
  String wallet;

  Operation({
    this.id,
    this.title,
    this.amount,
    this.isContribution,
    this.date,
    this.wallet,
  });

  Operation.fromMap(Map snapshot, String id)
      : id = id ?? "",
        title = snapshot['title'] ?? "",
        amount = snapshot['amount'] ?? 0.0,
        isContribution = snapshot['isContribution'] ?? true,
        date = snapshot['date'] ?? DateTime.now(),
        wallet = snapshot['wallet'] ?? "";
  toJson() {
    return {
      "title": title,
      "amount": amount,
      "isContribution": isContribution,
      "date": date,
      "wallet": wallet,
    };
  }
}
