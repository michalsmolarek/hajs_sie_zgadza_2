import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:hajs_sie_zgadza_2/core/viewmodels/user_view_model.dart';
import '../models/user.dart' as ModelUser;

import '../../locator.dart';

enum Status {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated,
  WrongEmail,
  InvalidEmail,
  Registering,
  EmailExist,
}

class AuthService with ChangeNotifier {
  FirebaseAuth _auth;
  User _user;
  Status _status = Status.Uninitialized;
  UserViewModel userVM = locator<UserViewModel>();

  AuthService.instance() : _auth = FirebaseAuth.instance {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      _onAuthStateChanged(user);
    });
  }

  Status get status => _status;
  User get user => _user;

  Future<bool> signIn(String email, String password) async {
    _status = Status.Authenticating;
    try {
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _status = Status.WrongEmail;
      }
      print(e.code);
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(String email, String password, String username) async {
    try {
      _status = Status.Authenticating;
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) {
        ModelUser.User usr = ModelUser.User(
          id: user.user.uid,
          mail: email,
          name: username,
        );
        userVM.add(usr);
      });
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        _status = Status.EmailExist;
      }
      print(e);
      notifyListeners();
      return false;
    }
  }

  setStatusUnauthenticated() {
    _status = Status.Unauthenticated;
  }

  Future signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _onAuthStateChanged(User firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      _status = Status.Authenticated;
    }
    notifyListeners();
  }
}
