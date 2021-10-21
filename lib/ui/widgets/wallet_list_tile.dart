import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hajs_sie_zgadza_2/core/services/auth_service.dart';
import 'package:hajs_sie_zgadza_2/core/viewmodels/user_view_model.dart';
import 'package:hajs_sie_zgadza_2/core/viewmodels/wallet_view_model.dart';
import 'package:hajs_sie_zgadza_2/ui/shared/utility.dart';
import 'package:provider/provider.dart';

class WalletListTile extends StatelessWidget {
  final String id;
  final String userId;
  final String title;
  final Timestamp dateCreated;
  final double amount;
  final bool isCurrent;

  const WalletListTile({
    this.id,
    this.userId,
    this.title,
    this.dateCreated,
    this.amount,
    this.isCurrent,
  });

  factory WalletListTile.fromDocument(QueryDocumentSnapshot doc) {
    return WalletListTile(
      id: doc.id,
      userId: doc.get("userId"),
      title: doc.get("title"),
      dateCreated: doc.get("dateCreated"),
      amount: doc.get("amount").toDouble(),
      isCurrent: doc.get("isCurrent"),
    );
  }

  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletViewModel>(context);
    final authProvider = Provider.of<AuthService>(context);
    final userProvider = Provider.of<UserViewModel>(context);

    return GestureDetector(
      onTap: () {
        print(id);
        userProvider.setCurrentWallet(authProvider.user.uid, id);
        walletProvider.setCurrentWallet(id, authProvider.user.uid);
      },
      child: Opacity(
        opacity: isCurrent ? 1 : 0.5,
        child: Container(
          margin: EdgeInsets.only(left: 15),
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            gradient: Utility.GRADIENT,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      amount == 0.0 ? "Brak hajsu" : "${amount.round()} PLN",
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
