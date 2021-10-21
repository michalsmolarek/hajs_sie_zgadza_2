import 'package:flutter/material.dart';
import 'package:hajs_sie_zgadza_2/core/services/auth_service.dart';
import 'package:hajs_sie_zgadza_2/ui/shared/loading.dart';
import 'package:hajs_sie_zgadza_2/ui/views/home_page.dart';
import 'package:hajs_sie_zgadza_2/ui/views/auth_page.dart';
import 'package:provider/provider.dart';

class PreparePage extends StatelessWidget {
  static const routeName = "/prepare";

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthService>(context);

    Widget setPage() {
      print(authProvider.status);
      Widget widget;
      switch (authProvider.status) {
        case Status.Unauthenticated:
        case Status.WrongEmail:
        case Status.Authenticating:
        case Status.InvalidEmail:
        case Status.EmailExist:
          widget = AuthPage();
          break;
        case Status.Authenticated:
          widget = HomePage(user: authProvider.user);
          break;
        default:
          widget = LoadingCircleIndicator();
          break;
      }
      return widget;
    }

    return setPage();
  }
}
