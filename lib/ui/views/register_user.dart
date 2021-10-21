import 'package:flutter/material.dart';
import 'package:hajs_sie_zgadza_2/core/services/auth_service.dart';
import 'package:hajs_sie_zgadza_2/ui/shared/loading.dart';
import 'package:hajs_sie_zgadza_2/ui/shared/utility.dart';
import 'package:provider/provider.dart';

class RegisterUser extends StatefulWidget {
  final Function changeIsLogin;

  const RegisterUser({this.changeIsLogin});
  @override
  _LoginUserState createState() => _LoginUserState();
}

class _LoginUserState extends State<RegisterUser> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _username = TextEditingController();
  bool isLogin = true;
  bool showXemail = false;
  bool showUsername = false;
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
                        controller: _username,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Wpisz nazwę użytkownika";
                          } else if (value.trim().length < 2) {
                            return "Nazwa użytkowniak powinna składać się z co najmniej 3 znaków";
                          } else {
                            return null;
                          }
                        },
                        maxLines: 1,
                        onChanged: (v) {
                          setState(() {
                            if (v.length > 0) {
                              showUsername = true;
                            } else {
                              showUsername = false;
                            }
                          });
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          suffixIcon: showUsername
                              ? GestureDetector(
                                  onTap: () {
                                    _username.clear();
                                    setState(() {
                                      showUsername = false;
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
                            Icons.person,
                            color: Utility.PRIMARY_COLOR,
                          ),
                          labelText: "Nazwa użytkownika",
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
                            authProvider.register(
                              _email.text.trim(),
                              _password.text.trim(),
                              _username.text.trim(),
                            );

                            setState(() {
                              _username.clear();
                              _email.clear();
                              _password.clear();
                              showXemail = false;
                              showXpass = false;
                              showUsername = false;
                            });
                          }
                        },
                        child: Text(
                          "Zarejestruj się",
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
                        widget.changeIsLogin();
                      },
                      child: Text(
                        "Mam już konto",
                        style: TextStyle(color: Colors.black, fontSize: 13),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    authProvider.status == Status.EmailExist
                        ? Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Adres E-mail jest już używany przez innego użytkownika. Sorry.",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red, fontSize: 15),
                            ),
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Czy wiesz, że...",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        "Jacek Sasin w 2020 roku wydał ponad 70 milionów złotych na nielegalne wybory, które się nie odbyły.",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
