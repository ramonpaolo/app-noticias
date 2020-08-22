import 'package:flutter/material.dart';
import 'package:simple_splashscreen/simple_splashscreen.dart';
import './Registrar.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(primarySwatch: Colors.red, buttonColor: Colors.red),
    title: "Jornal",
    color: Colors.red,
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Simple_splashscreen(
        context: context,
        splashscreenWidget: Splas(),
        gotoWidget: SignInPage(),
        timerInSeconds: 5);
  }
}

class Splas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Text(
          "Bem Vindo",
          style: TextStyle(color: Colors.white, fontSize: 30.0),
        ),
      ),
    );
  }
}
