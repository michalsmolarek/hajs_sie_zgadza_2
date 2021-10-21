import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hajs_sie_zgadza_2/core/services/auth_service.dart';
import 'package:hajs_sie_zgadza_2/ui/shared/utility.dart';
import 'package:hajs_sie_zgadza_2/ui/widgets/bottom_sheet.dart';
import 'package:hajs_sie_zgadza_2/ui/widgets/last_operations.dart';
import 'package:hajs_sie_zgadza_2/ui/widgets/wallets.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/home";
  final User user;

  const HomePage({this.user});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollController = new ScrollController();
  bool showFab = false;

  @override
  void initState() {
    super.initState();
  }

  addOperation() {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        context: context,
        builder: (context) => AddBottomSheet());
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthService>(context);

    return Scaffold(
      backgroundColor: Utility.BG_COLOR,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: Container(
          decoration: BoxDecoration(
            gradient: Utility.GRADIENT,
            borderRadius: new BorderRadius.vertical(
              bottom: new Radius.elliptical(
                  MediaQuery.of(context).size.width, 30.0),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Container(
              padding: EdgeInsets.only(top: 15),
              child: Text(
                "Hajs sie zgadza",
                style: TextStyle(
                  fontFamily: "Signatra",
                  fontSize: 40.0,
                  color: Colors.white,
                ),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  print("Menu");
                  authProvider.signOut();
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 15, right: 15),
                  child: Icon(
                    Icons.more_vert,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification.metrics.pixels > 100 &&
              scrollNotification.metrics.axis == Axis.vertical) {
            setState(() {
              showFab = true;
            });
          } else {
            setState(() {
              showFab = false;
            });
          }
          return true;
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                child: Wallets(),
              ),
              SizedBox(
                height: 20,
              ),
              StickyHeader(
                header: Material(
                  elevation: 0,
                  child: Container(
                    color: Utility.BG_COLOR,
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Ostatnie operacje",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900, fontSize: 25.0),
                            ),
                            GestureDetector(
                              onTap: () {
                                addOperation();
                              },
                              child: Icon(
                                Icons.add_circle_rounded,
                                color: Utility.PRIMARY_COLOR,
                                size: 35,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(
                            "Bieżący hajs",
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                content: Column(
                  children: [
                    Container(
                      child: LastOperations(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: showFab
          ? FloatingActionButton(
              backgroundColor: Utility.PRIMARY_COLOR,
              child: new Icon(Icons.arrow_upward),
              onPressed: () {
                _scrollController.animateTo(
                  0.0,
                  curve: Curves.easeOut,
                  duration: const Duration(milliseconds: 500),
                );
              },
            )
          : null,
    );
  }
}
