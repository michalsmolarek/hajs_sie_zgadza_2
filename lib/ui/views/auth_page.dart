import 'package:flutter/material.dart';
import 'package:hajs_sie_zgadza_2/ui/views/login_user.dart';
import 'package:hajs_sie_zgadza_2/ui/views/register_user.dart';
import '../shared/utility.dart';

class AuthPage extends StatefulWidget {
  static const routeName = "/login";
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  final _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  changeIsLogin() {
    print("change");
    setState(() {
      isLogin = !isLogin;
    });
    print(isLogin);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Utility.BG_COLOR,
      key: _key,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: Container(
          decoration: BoxDecoration(
            gradient: Utility.GRADIENT,
            borderRadius: new BorderRadius.vertical(
                bottom: new Radius.elliptical(
                    MediaQuery.of(context).size.width, 30.0)),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Container(
              padding: EdgeInsets.only(top: 20),
              child: Text(isLogin ? "Zaloguj się" : "Zarejestruj się"),
            ),
          ),
        ),
      ),
      body: Container(
        child: isLogin
            ? LoginUser(changeIsLogin: changeIsLogin)
            : RegisterUser(changeIsLogin: changeIsLogin),
      ),
    );
  }
}
