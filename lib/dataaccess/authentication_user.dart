import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


class AuthenticationUser {

  static int userId = -1;

  static Future<bool> signup(String email, String password, String passwordCheck) async {

    //login.dartから送信された情報を表示
    print(email);
    print(password);
    print(passwordCheck);
    if(!(password.compareTo(passwordCheck) == 0)) {
      return false;
    }

    try {
      // メール/パスワードでユーザー登録
      final FirebaseAuth auth = FirebaseAuth.instance;
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      print("success");
      return true;

    } catch (e) {
      // ユーザー登録に失敗した場合
      print(e);
      return false;
    }

  }



  static Future<bool> authenticate(String email, String password) async {

    //login.dartから送信された情報を表示
    print(email);
    print(password);

    try {
      // メール/パスワードでユーザー登録
      final FirebaseAuth auth = FirebaseAuth.instance;
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      print("success");
      return true;

    } catch (e) {
      // ユーザー登録に失敗した場合
      print(e);
      return false;
    }

  }
}