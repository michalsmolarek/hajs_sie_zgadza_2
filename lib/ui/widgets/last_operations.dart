import 'package:flutter/material.dart';
import 'package:hajs_sie_zgadza_2/core/models/operation.dart';
import 'package:hajs_sie_zgadza_2/core/services/auth_service.dart';
import 'package:hajs_sie_zgadza_2/core/viewmodels/operation_view_model.dart';
import 'package:hajs_sie_zgadza_2/core/viewmodels/user_view_model.dart';
import 'package:hajs_sie_zgadza_2/ui/widgets/last_operation_tile.dart';
import 'package:provider/provider.dart';

class LastOperations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final operationsProvider = Provider.of<OperationViewModel>(context);
    final authProvider = Provider.of<AuthService>(context);
    final userProvider = Provider.of<UserViewModel>(context);

    return FutureBuilder(
      future: operationsProvider.fetch(authProvider.user.uid),
      builder: (context, AsyncSnapshot<List<Operation>> snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        } else {
          List<Operation> list = snapshot.data;

          return ListView.builder(
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (context, index) {
                return LastOperationTile(operation: list[index]);
              });
        }
      },
    );
  }
}
