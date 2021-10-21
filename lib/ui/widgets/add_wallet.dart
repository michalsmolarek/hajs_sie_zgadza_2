import 'package:flutter/material.dart';
import 'package:hajs_sie_zgadza_2/core/models/wallet.dart';
import 'package:hajs_sie_zgadza_2/core/services/auth_service.dart';
import 'package:hajs_sie_zgadza_2/core/viewmodels/wallet_view_model.dart';
import 'package:hajs_sie_zgadza_2/ui/shared/utility.dart';

import 'package:provider/provider.dart';

class WalletAdd extends StatefulWidget {
  @override
  _WalletAddState createState() => _WalletAddState();
}

class _WalletAddState extends State<WalletAdd> {
  TextEditingController _walletTitleController = TextEditingController();

  addWallet(BuildContext context,
      {WalletViewModel walletProvider, AuthService authProvider}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 270,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Dodaj nowy portfel",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Utility.PRIMARY_COLOR,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      controller: _walletTitleController,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                      autofocus: true,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Utility.PRIMARY_COLOR, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Utility.PRIMARY_COLOR, width: 1.0),
                        ),
                        labelText: "Nazwij Portfel",
                        labelStyle: TextStyle(color: Utility.PRIMARY_COLOR),
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      padding: EdgeInsets.all(5),
                      width: MediaQuery.of(context).size.width / 1.5,
                      decoration: BoxDecoration(
                        gradient: Utility.GRADIENT,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          print("dodaje");
                          walletProvider.add(
                              Wallet(
                                  amount: 0,
                                  dateCreated: DateTime.now(),
                                  title: _walletTitleController.text,
                                  userId: authProvider.user.uid,
                                  isCurrent: false),
                              authProvider.user.uid);
                          Navigator.of(context).pop();
                          _walletTitleController.clear();
                        },
                        child: Text(
                          "Dodaj portfel",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthService>(context);
    final walletProvider = Provider.of<WalletViewModel>(context);
    return GestureDetector(
      onTap: () {
        addWallet(context,
            authProvider: authProvider, walletProvider: walletProvider);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.add,
                  color: Utility.PRIMARY_COLOR,
                  size: 50.0,
                )),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Dodaj portfel",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
