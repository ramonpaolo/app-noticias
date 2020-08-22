import 'package:flutter/material.dart';

class Noticia extends StatelessWidget {
  String titulo, autor, texto, imagem;

  Noticia({Key key, @required this.titulo, @required this.autor,
      @required this.texto, @required this.imagem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("$titulo"),
          backgroundColor: Colors.red,
        ),
        body: SingleChildScrollView(
            child: Column(
          textDirection: TextDirection.ltr,
          children: [
            Text("${texto}")
          ],
        )));
  }
}
