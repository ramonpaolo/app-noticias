import './Criar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import './Noticia.dart';
import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  @override
  void initState() {
    print("Iniciou o Index");

    mostrar();
    super.initState();
  }

  List<String> lista = ["Ramon", "Dudu"];
  Firestore _firestore = Firestore.instance;
  List<DocumentSnapshot> _usuarios = [];
  int limit = 10;
  UniqueKey uniqueKey = UniqueKey();
  final _streamController = StreamController<List<DocumentSnapshot>>();

  Future mostrar() async {
    Query _query = _firestore
        .collection("usuarios")
        .orderBy("data", descending: true)
        .limit(limit);

    QuerySnapshot _querySnapshot = await _query.getDocuments();
    _streamController.add(_usuarios = _querySnapshot.documents);

    print("Carregando");
  }

  String titulo = "texte",
      texto = "tex",
      descricao = "desci",
      imagem = "a",
      autor = "r";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Criar()));
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          backgroundColor: Colors.red,
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: IconButton(icon: Icon(Icons.search), onPressed: () {}))
          ],
          elevation: 0.0,
          actionsIconTheme: IconThemeData(color: Colors.white),
          title: TextField(
            cursorRadius: Radius.circular(10.0),
            scrollPadding: EdgeInsets.only(left: 10.0),
            cursorColor: Colors.white,
            keyboardType: TextInputType.text,
            autocorrect: true,
            textInputAction: TextInputAction.search,
            keyboardAppearance: Brightness.light,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
                labelText: "Pesquise pelo título",
                labelStyle: TextStyle(
                    color: Colors.white, decorationColor: Colors.white),
                fillColor: Colors.white,
                hoverColor: Colors.white,
                focusColor: Colors.white,
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(30.0)),
                contentPadding: EdgeInsets.zero),
          ),
        ),
        body: Column(
          textDirection: TextDirection.ltr,
          children: [
            Container(
                height: 50,
                width: 550,
                color: Colors.red,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: SingleChildScrollView(
                        dragStartBehavior: DragStartBehavior.start,
                        scrollDirection: Axis.horizontal,
                        child: Row(children: [
                          buildClipRRect("Tecnologia"),
                          buildClipRRect("Programação"),
                          buildClipRRect("Política"),
                          buildClipRRect("Cultura"),
                          buildClipRRect("Lazer"),
                          buildClipRRect("Livros")
                        ])))),
            Expanded(
                child: SizedBox(
                    child: RefreshIndicator(
                        onRefresh: () async {
                          setState(() async {
                            await mostrar();
                          });
                        },
                        child: StreamBuilder(
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.none) {
                                return Center(
                                    child: Text(
                                  "Error",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 30.0),
                                ));
                              } else if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else {
                                return ListView.builder(
                                    addAutomaticKeepAlives: true,
                                    shrinkWrap: true,
                                    key: UniqueKey(),
                                    itemCount: _usuarios.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Hero(
                                              tag: DateTime.now().toString(),
                                              transitionOnUserGestures: true,
                                              child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (route) =>
                                                                    Noticia(
                                                                      titulo: _usuarios[index]
                                                                              .data[
                                                                          "titulo"],
                                                                      texto: _usuarios[index]
                                                                              .data[
                                                                          "texto"],
                                                                      autor: _usuarios[index]
                                                                              .data[
                                                                          "nome"],
                                                                      imagem: _usuarios[index]
                                                                              .data[
                                                                          "imagem"],
                                                                    )));
                                                  },
                                                  child: Card(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(10.0),
                                                      child: Column(
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            child:
                                                                Image.network(
                                                              "https://cdn.pixabay.com/photo/2020/03/08/17/44/creativity-4913182__340.jpg",
                                                              loadingBuilder:
                                                                  (context,
                                                                      child,
                                                                      loading) {
                                                                return loading !=
                                                                        null
                                                                    ? Center(
                                                                        child:
                                                                            CircularProgressIndicator())
                                                                    : child;
                                                              },
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 15.0),
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                    "Titulo: "),
                                                                Text(
                                                                    "${_usuarios[index].data["titulo"]}")
                                                              ],
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Nome autor: "),
                                                              Text(
                                                                  "${_usuarios[index].data["nome"]}")
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ))));
                                    });
                              }
                            },
                            stream: _streamController.stream))))
          ],
        ));
  }

  Widget buildClipRRect(String categoria) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: RaisedButton(
          onPressed: () {},
          child: Text(
            categoria,
            style: TextStyle(color: Colors.white),
          ),
        ));
  }
}
