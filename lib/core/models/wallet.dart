class Wallet {
  String id;
  String userId;
  String title;
  DateTime dateCreated;
  double amount;
  bool isCurrent;

  Wallet(
      {this.id,
      this.userId,
      this.amount,
      this.dateCreated,
      this.title,
      this.isCurrent});

  void setCurrent() {
    isCurrent = true;
  }

  void setNotCurrent() {
    isCurrent = false;
  }

  Wallet.fromMap(Map snapshot, String id)
      : id = id ?? "",
        userId = snapshot['userId'] ?? "",
        title = snapshot['name'] ?? "",
        dateCreated = snapshot['dateCreated'] ?? DateTime.now(),
        amount = snapshot['amount'] ?? 0.0;

  toJson() {
    return {
      "userId": userId,
      "title": title,
      "dateCreated": dateCreated,
      "amount": amount,
      "isCurrent": isCurrent,
    };
  }
}
