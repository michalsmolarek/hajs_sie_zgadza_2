import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hajs_sie_zgadza_2/ui/views/home_page.dart';
import 'package:hajs_sie_zgadza_2/ui/views/prepare_page.dart';
import 'package:hajs_sie_zgadza_2/ui/views/auth_page.dart';
import 'package:provider/provider.dart';

import 'core/services/auth_service.dart';
import 'core/viewmodels/operation_view_model.dart';
import 'core/viewmodels/user_view_model.dart';
import 'core/viewmodels/wallet_view_model.dart';
import 'locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Coś poszlo nie tak"));
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => locator<OperationViewModel>(),
              ),
              ChangeNotifierProvider(
                create: (_) => locator<UserViewModel>(),
              ),
              ChangeNotifierProvider(
                create: (_) => locator<WalletViewModel>(),
              ),
              ChangeNotifierProvider(
                create: (_) => locator<AuthService>(),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                fontFamily: "Poppins",
                primarySwatch: Colors.blue,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              initialRoute: PreparePage.routeName,
              routes: {
                PreparePage.routeName: (ctx) => PreparePage(),
                AuthPage.routeName: (ctx) => AuthPage(),
                HomePage.routeName: (ctx) => HomePage(),
              },
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
