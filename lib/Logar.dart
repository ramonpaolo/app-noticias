import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './Index.dart';
import 'dart:async';
import './Registrar.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String email, password;

  void login() async {
    try {
      FirebaseUser user = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password))
          .user as FirebaseUser;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Index()));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/G1_logo.svg.png",
                  width: 200.0,
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.fill,
                ),
                Divider(),
                TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: "Digite seu email"),
                  onChanged: (c) {
                    email = c;
                  },
                ),
                TextField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Digite sua senha'),
                  onChanged: (c) {
                    password = c;
                  },
                ),
                Divider(),
                RaisedButton(
                  onPressed: () {
                    login();
                  },
                  child: Text(
                    "Logar",
                    style: TextStyle(color: Colors.white),
                  ),
                  padding: EdgeInsets.only(left: 140.0, right: 140.0),
                ),
                Divider(
                  color: Colors.white,
                ),
                Text("Não tem uma conta? Crie uma"),
                RaisedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => SignInPage()));
                  },
                  child: Text(
                    "Criar conta",
                    style: TextStyle(color: Colors.white),
                  ),
                  padding: EdgeInsets.only(left: 125, right: 125),
                )
              ],
            )));
  }
}
