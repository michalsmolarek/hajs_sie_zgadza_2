class User {
  String id;
  String name;
  String mail;
  String currentWallet;

  User({
    this.id,
    this.name,
    this.mail,
    this.currentWallet,
  });

  User.fromMap(Map snapshot, String id)
      : id = id ?? "",
        name = snapshot['name'] ?? "",
        mail = snapshot['mail'] ?? "",
        currentWallet = snapshot['currentWallet'] ?? "";

  // TODO: przerobić to,żeby user mial ID a nie wallet mial isCurrent, bo to bez sensu

  toJson() {
    return {
      "id": id,
      "name": name,
      "mail": mail,
      "currentWallet": "",
    };
  }
}
