import 'package:flutter/material.dart';
import 'home.dart';
import 'package:app/dataaccess/authentication_user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

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
        title: Text('JboyApp'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'ユーザー名を入力してください',
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
                      Navigator.push(
                        context,

                        //ログインできたかどうかで遷移先を選択
                        loginSuccess == true ?
                        MaterialPageRoute(builder: (context) => Home()):
                        MaterialPageRoute(builder: (context) => LoginPage()),
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