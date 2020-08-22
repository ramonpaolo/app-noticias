import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import './Logar.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _globalKeySnack = GlobalKey<ScaffoldState>();
  String email, password;

  void registrar(BuildContext context) async {
    try {
      FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user as FirebaseUser;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => RegisterPage()));
      //Scaffold.of(context).showSnackBar(SnackBar(content: Text("Criado")),);
    } catch (e) {
      print(e);
      _globalKeySnack.currentState.showSnackBar(SnackBar(
        content: Text("Usuário já existente"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _globalKeySnack,
        body: SingleChildScrollView(child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Form(
                key: _globalKey,
                child: Padding(padding: EdgeInsets.only(top: 50.0) ,child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/registrar.webp",
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.fill,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Colors.red,
                      cursorRadius: Radius.circular(10.0),
                      showCursor: true,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Vazio";
                        } else if (value.length <= 8) {
                          return "Menor que 8";
                        } else if (value.length >= 36) {
                          return "Maior que 35";
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "Digite seu email",
                        hintText: "Ex: leticia13ferreira@gmail.com",
                      ),
                      onChanged: (context) {
                        email = context;
                      },
                    ),
                    Divider(),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      cursorRadius: Radius.circular(10.0),
                      cursorColor: Colors.red,
                      decoration: InputDecoration(
                          labelText: "Digite uma senha",
                          fillColor: Colors.red,
                          counterStyle: TextStyle(color: Colors.red),
                          hoverColor: Colors.red),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Vazio";
                        } else if (value.length <= 7) {
                          return "Menor que 8";
                        } else if (value.length >= 23) {
                          return "Maior que 22";
                        }
                      },
                      onChanged: (context) {
                        password = context;
                      },
                    ),
                    Divider(color: Colors.white,),
                    RaisedButton(
                      padding: EdgeInsets.fromLTRB(125, 0, 125, 0),
                      onPressed: () {
                        setState(() {
                          if (_globalKey.currentState.validate()) {
                            registrar(context);
                          } else {
                            _globalKeySnack.currentState.showSnackBar(SnackBar(
                              content: Text("Não possivel criar conta"),
                            ));
                          }
                        });
                      },
                      child: Text(
                        "Criar conta",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Divider(color: Colors.white,),
                    Text("Já tem uma conta?"),
                    RaisedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()));
                      },
                      child: Text(
                        "Logar",
                        style: TextStyle(color: Colors.white),
                      ),
                      padding: EdgeInsets.fromLTRB(140, 0, 140, 0),
                    ),
                  ],
                ))))));
  }
}
