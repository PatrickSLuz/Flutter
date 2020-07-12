import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gerenciar_loja_virtual/login/validators/login_validator.dart';
import 'package:rxdart/rxdart.dart';

enum LoginState { IDLE, LOADING, SUCCESS, FAIL }

class LoginBloc extends BlocBase with LoginValidator {
  StreamSubscription _streamSubscription;

  LoginBloc() {
    // verificar dps hahaha
    // manter logado
    _streamSubscription =
        FirebaseAuth.instance.onAuthStateChanged.listen((user) async {
      if (user != null) {
        if (await verifyPrivileges(user)) {
          _stateController.add(LoginState.SUCCESS);
        } else {
          FirebaseAuth.instance.signOut();
          _stateController.add(LoginState.FAIL);
        }
      } else {
        _stateController.add(LoginState.IDLE);
      }
    });
  }

  final _emailController = BehaviorSubject<String>();
  Stream<String> get outEmail =>
      _emailController.stream.transform(validateEmail);
  Function(String) get changeEmail => _emailController.sink.add;

  final _passwordController = BehaviorSubject<String>();
  Stream<String> get outPassword =>
      _passwordController.stream.transform(validatePassword);
  Function(String) get changePassword => _passwordController.sink.add;

  Stream<bool> get outSubmitValid =>
      Observable.combineLatest2(outEmail, outPassword, (a, b) => true);

  final _stateController = BehaviorSubject<LoginState>();
  Stream<LoginState> get outState => _stateController.stream;

  void submit() {
    final email = _emailController.value;
    final password = _passwordController.value;
    print(email);
    print(password);
    _stateController.add(LoginState.LOADING);

    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .catchError((error) {
      _stateController.add(LoginState.FAIL);
    });
  }

  Future<bool> verifyPrivileges(FirebaseUser user) async {
    return await Firestore.instance
        .collection("admins")
        .document(user.uid)
        .get()
        .then((doc) {
      if (doc.data != null) {
        return true;
      } else {
        return false;
      }
    }).catchError((error) => false);
  }

  @override
  void dispose() {
    _emailController.close();
    _passwordController.close();
    _stateController.close();
    _streamSubscription.cancel();
  }
}
