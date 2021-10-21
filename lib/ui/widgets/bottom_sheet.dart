import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:hajs_sie_zgadza_2/core/models/operation.dart';
import 'package:hajs_sie_zgadza_2/core/services/auth_service.dart';
import 'package:hajs_sie_zgadza_2/core/viewmodels/operation_view_model.dart';
import 'package:hajs_sie_zgadza_2/core/viewmodels/user_view_model.dart';
import 'package:hajs_sie_zgadza_2/ui/shared/utility.dart';
import 'package:provider/provider.dart';

class AddBottomSheet extends StatelessWidget {
  final TextEditingController _addOperationAmountController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    final operationProvider = Provider.of<OperationViewModel>(context);
    final userProvider = Provider.of<UserViewModel>(context);
    final authProvider = Provider.of<AuthService>(context);

    addOperation() async {
      bool contribution =
          double.parse(_addOperationAmountController.text.trim()) > 0
              ? true
              : false;
      await userProvider.getById(authProvider.user.uid).then((user) {
        operationProvider.add(
            Operation(
              amount: double.parse(_addOperationAmountController.text.trim()),
              date: Timestamp.fromDate(DateTime.now()),
              title: "Operacja",
              wallet: user.currentWallet,
              isContribution: contribution,
            ),
            authProvider.user.uid);
        Navigator.of(context).pop();
      });
    }

    return Container(
      height: 400,
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: [
          new Container(
            width: 50.0,
            height: 7.0,
            margin: EdgeInsets.only(bottom: 20.0),
            decoration: new BoxDecoration(
              borderRadius: new BorderRadius.circular(10.0),
              color: Colors.grey[400],
            ),
          ),
          Text(
            "Dodaj nową operację",
            style: TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            controller: _addOperationAmountController,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
            ),
            autofocus: true,
            decoration: InputDecoration(
              suffixText: "PLN",
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Utility.PRIMARY_COLOR, width: 1.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Utility.PRIMARY_COLOR, width: 1.0),
              ),
              labelText: "Wpisz ilość PLN",
              labelStyle: TextStyle(color: Utility.PRIMARY_COLOR),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: CustomRadioButton(
              enableShape: true,
              width: MediaQuery.of(context).size.width * 0.435,
              elevation: 0,
              defaultSelected: "add",
              height: 40,
              unSelectedColor: Theme.of(context).canvasColor,
              buttonLables: [
                'Dodaję',
                'Odejmuję',
              ],
              buttonValues: [
                "add",
                "divide",
              ],
              unSelectedBorderColor: Utility.PRIMARY_COLOR,
              selectedBorderColor: Utility.PRIMARY_COLOR,
              buttonTextStyle: ButtonTextStyle(
                  selectedColor: Colors.white,
                  unSelectedColor: Colors.black,
                  textStyle: TextStyle(fontSize: 16)),
              radioButtonValue: (value) {
                print(value);
              },
              selectedColor: Utility.PRIMARY_COLOR,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            padding: EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width / 1.5,
            decoration: BoxDecoration(
              gradient: Utility.GRADIENT,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: MaterialButton(
              onPressed: () {
                addOperation();
              },
              child: Text(
                "Dodaj operację",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
