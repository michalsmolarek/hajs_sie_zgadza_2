import 'package:flutter/material.dart';
import 'package:hajs_sie_zgadza_2/core/services/auth_service.dart';
import 'package:hajs_sie_zgadza_2/ui/shared/loading.dart';
import 'package:hajs_sie_zgadza_2/ui/shared/utility.dart';
import 'package:provider/provider.dart';

class LoginUser extends StatefulWidget {
  final Function changeIsLogin;

  const LoginUser({this.changeIsLogin});
  @override
  _LoginUserState createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool isLogin = true;
  bool showXemail = false;
  bool showXpass = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthService>(context);
    return Container(
      child: authProvider.status == Status.Authenticating
          ? LoadingCircleIndicator()
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 50),
                      child: Text(
                        "Hajs sie zgadza",
                        style: TextStyle(
                            fontFamily: "Signatra",
                            fontSize: 50.0,
                            color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _email,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Wpisz adres Email";
                          } else if (!value.contains("@")) {
                            return "Wpisz poprawny adres Email";
                          } else if (!value.contains(".")) {
                            return "Wpisz poprawny adres Email";
                          } else {
                            return null;
                          }
                        },
                        maxLines: 1,
                        onChanged: (v) {
                          setState(() {
                            if (v.length > 0) {
                              showXemail = true;
                            } else {
                              showXemail = false;
                            }
                          });
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          suffixIcon: showXemail
                              ? GestureDetector(
                                  onTap: () {
                                    _email.clear();
                                    setState(() {
                                      showXemail = false;
                                    });
                                  },
                                  child: Icon(
                                    Icons.clear,
                                    size: 15,
                                    color: Colors.grey,
                                  ),
                                )
                              : SizedBox(),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Utility.PRIMARY_COLOR,
                          ),
                          labelText: "Email",
                          labelStyle: TextStyle(
                              color: Utility.PRIMARY_COLOR, fontSize: 19),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Utility.PRIMARY_COLOR),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onChanged: (v) {
                          setState(() {
                            if (v.length > 0) {
                              showXpass = true;
                            } else {
                              showXpass = false;
                            }
                          });
                        },
                        obscureText: true,
                        controller: _password,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Wpsiz hasło";
                          } else if (value.length < 6) {
                            return "Hasło składa się z conajmiej 6 znaków";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Utility.PRIMARY_COLOR,
                            ),
                            suffixIcon: showXpass
                                ? GestureDetector(
                                    onTap: () {
                                      _password.clear();
                                      setState(() {
                                        showXpass = false;
                                      });
                                    },
                                    child: Icon(
                                      Icons.clear,
                                      size: 15,
                                      color: Colors.grey,
                                    ),
                                  )
                                : SizedBox(),
                            labelText: "Hasło",
                            labelStyle: TextStyle(
                                color: Utility.PRIMARY_COLOR, fontSize: 19),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Utility.PRIMARY_COLOR),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 12,
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
                          if (_formKey.currentState.validate()) {
                            authProvider.signIn(
                                _email.text.trim(), _password.text.trim());
                            setState(() {
                              _email.clear();
                              _password.clear();
                              showXemail = false;
                              showXpass = false;
                            });
                          }
                        },
                        child: Text(
                          "Zaloguj się",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        authProvider.setStatusUnauthenticated();
                        widget.changeIsLogin();
                      },
                      child: Text(
                        "Nie masz konta?",
                        style: TextStyle(color: Colors.black, fontSize: 13),
                      ),
                    ),
                    authProvider.status == Status.WrongEmail
                        ? Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Nie znaleziono użytkownika",
                              style: TextStyle(color: Colors.red, fontSize: 15),
                            ),
                          )
                        : SizedBox(),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
    );
  }
}
