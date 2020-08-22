import 'package:flutter/material.dart';

class Criar extends StatefulWidget {
  @override
  _CriarState createState() => _CriarState();
}

class _CriarState extends State<Criar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Criar Conteudo"), centerTitle: true,), body: SingleChildScrollView(child: Form(child: Padding(padding: EdgeInsets.fromLTRB(20, 40, 20, 0) ,child: Column(children: [
      buildTextFormField(TextInputType.text),
      //Center(child: Text("EM DESENVOLVIMENTO!!!", style: TextStyle(color: Colors.red, fontSize: 30.0),))
    ],),), ),),);
  }

  Widget buildTextFormField(TextInputType entradaDeTexto){

    return TextFormField(keyboardType: entradaDeTexto, );

  }

}