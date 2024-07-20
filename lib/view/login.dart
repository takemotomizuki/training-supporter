import 'package:app/view/top.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'package:app/dataaccess/authentication_user.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key, required this.warningMessage});
  final String warningMessage;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure = true;
  String email = "";
  String password = "";




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
                      labelText: 'Password',
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
              Center(
                child: ElevatedButton(
                    onPressed: () async {
                      final loginSuccess = await AuthenticationUser.authenticate(email, password);

                      // Navigator.push(
                      //   context,
                      //   //ログインできたかどうかで遷移先を選択
                      //   loginSuccess == true ?
                      //   MaterialPageRoute(builder: (context) => Home()):
                      //   MaterialPageRoute(builder: (context) => LoginPage(), allowSnapshotting: false),
                      // );

                      Navigator.pushReplacement(
                        context,
                          loginSuccess == true ?
                            MaterialPageRoute(builder: (BuildContext context) =>  Top(userId: '',)):
                            MaterialPageRoute(builder: (BuildContext context) =>  LoginPage(warningMessage: "入力が間違っています。",))
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