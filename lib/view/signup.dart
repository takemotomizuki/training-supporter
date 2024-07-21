import 'package:app/view/top.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'package:app/dataaccess/authentication_user.dart';

import 'login.dart';

class SignupPage extends StatefulWidget {
  SignupPage({super.key, required this.warningMessage});
  final String warningMessage;

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _isObscure = true;
  String email = "";
  String password = "";
  String passwordCheck = "";



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Training Supporter'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              widget.warningMessage != "" ?
              Container(
                width: MediaQuery.of(context).size.width,
                //height: MediaQuery.of(context).size.height*0.04,
                child: Text(
                  widget.warningMessage,
                  style: TextStyle(color: Colors.red),
                ),
                /*decoration: BoxDecoration(
                  border: Border.all(color: Colors.redAccent),
                  color: Colors.red[50],
                ),*/
              ): Container(),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'メールアドレスを入力してください',
                  ),
                  onChanged: (String value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                      labelText: 'パスワード',
                      suffixIcon: IconButton(
                          icon: Icon(_isObscure
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          })),
                  onChanged: (String value) {
                    setState(() {
                      password= value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                      labelText: 'パスワード（確認）',
                      suffixIcon: IconButton(
                          icon: Icon(_isObscure
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          })),
                  onChanged: (String value) {
                    setState(() {
                      passwordCheck= value;
                    });
                  },
                ),
              ),





              Center(
                child: ElevatedButton(
                    onPressed: () async {
                      final signupSuccess = await AuthenticationUser.signup(email, password, passwordCheck);

                      Navigator.pushReplacement(
                          context,
                          signupSuccess == true ?
                          MaterialPageRoute(builder: (BuildContext context) =>  Top(userId: email,)):
                          MaterialPageRoute(builder: (BuildContext context) =>  SignupPage(warningMessage: "アカウント作成に失敗しました",))
                      );

                    },
                    child: Text('ログイン')
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}