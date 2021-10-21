import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hajs_sie_zgadza_2/core/services/auth_service.dart';
import 'package:hajs_sie_zgadza_2/core/viewmodels/wallet_view_model.dart';
import 'package:hajs_sie_zgadza_2/ui/widgets/wallet_list_tile.dart';
import 'package:provider/provider.dart';

import 'add_wallet.dart';

class Wallets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletViewModel>(context);
    final authProvider = Provider.of<AuthService>(context);

    return StreamBuilder<QuerySnapshot>(
        stream: walletProvider.fetchAsStream(authProvider.user.uid),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          List<Widget> list = [];
          snapshot.data.docs.forEach((element) {
            list.add(WalletListTile.fromDocument(element));
          });
          list.add(WalletAdd());
          return Container(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: list,
            ),
          );
        });
  }
}
