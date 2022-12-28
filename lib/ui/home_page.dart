import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _search;
  int _offset = 0;

  //https://api.giphy.com/v1/gifs/trending?api_key=ku2ccWtCSKi6ZrC2XePc08FfIeDbMWx1&limit=20&rating=g
  var url1 = Uri.parse(
      "https://api.giphy.com/v1/gifs/trending?api_key=ku2ccWtCSKi6ZrC2XePc08FfIeDbMWx1&limit=20&rating=g");

  //https://api.giphy.com/v1/gifs/search?api_key=ku2ccWtCSKi6ZrC2XePc08FfIeDbMWx1&q=dogs&limit=20&offset=0&rating=g&lang=pt
  var url2 = Uri.parse(
      "https://api.giphy.com/v1/gifs/search?api_key=ku2ccWtCSKi6ZrC2XePc08FfIeDbMWx1&q=dogs&limit=20&offset=0&rating=g&lang=pt");

  Future<Map> _getGiphfs() async {
    http.Response response;
    if (_search == null) {
      response = await http.get(url1);
    } else {
      response = await http.get(url2);
    }
    return json.decode(response.body);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getGiphfs().then((map) {
      print(map);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Image.network(
            "https://developers.giphy.com/branch/master/static/header-logo-0fec0225d189bc0eae27dac3e3770582.gif"),
      ),
      drawer: Drawer(
        child: ListView(
          children: const [
            UserAccountsDrawerHeader(
              accountName: Text(
                "Dario",
              ),
              accountEmail: Text(
                "dariodepaulamaciel@hotmail.com",
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.greenAccent,
                child: Text(
                  "D",
                ),
              ),
            ),
            ListTile(
              title: Text(
                "Este projeto foi criado como um experimento de aprendizado. \n\nEfetuando uso e consumo de duas APIs diferentes. A primeira dos gifs mais bem avaliados, a segunda dos gifs procurados",
                textAlign: TextAlign.justify,
              ),
            ),
            ListTile(
              title: Text("Obrigado por sua visualização."),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Pesquise Aqui!",
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
              ),
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: _getGiphfs(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return Container(
                      width: 200,
                      height: 200,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 5.0,
                      ),
                    );
                  default:
                    if (snapshot.hasError)
                      return Container(color: Colors.red);
                    else
                      return _createGifTable(context, snapshot);
                }
                ;
              },
            ),
          )
        ],
      ),
    );
  }

  //Widget _createGifTable(BuildContext context, AsyncSnapshot snapshot) {
  Widget _createGifTable(context, snapshot) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return GestureDetector();
      },
    );
  }
}
