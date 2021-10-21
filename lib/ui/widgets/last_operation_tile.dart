import 'package:flutter/material.dart';
import 'package:hajs_sie_zgadza_2/core/models/operation.dart';
import 'package:hajs_sie_zgadza_2/ui/shared/utility.dart';

class LastOperationTile extends StatelessWidget {
  final Operation operation;

  const LastOperationTile({this.operation});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 7.0,
            offset: Offset(0.0, 0.10),
          )
        ],
      ),
      child: ListTile(
        subtitle: Text(
          operation.date.toDate().toString(),
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 13.0,
          ),
        ),
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color:
                operation.isContribution ? Utility.PRIMARY_COLOR : Colors.red,
          ),
          child: Icon(
            operation.isContribution
                ? Icons.arrow_upward
                : Icons.arrow_downward_outlined,
            color: Colors.white,
            size: 20,
          ),
        ),
        title: Text(
          operation.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
          ),
        ),
        trailing: Text(
          operation.isContribution
              ? operation.amount.toString()
              : "-${operation.amount.toString()}",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: operation.isContribution
                  ? Utility.PRIMARY_COLOR
                  : Colors.red),
        ),
      ),
    );
  }
}
