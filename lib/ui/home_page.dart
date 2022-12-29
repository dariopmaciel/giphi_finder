import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:giphi_finder/ui/gif_page.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _search;
  int _offset = 0;

  Future<Map> _getGiphfs() async {
    http.Response response;
    var url1 = Uri.parse(
        "https://api.giphy.com/v1/gifs/trending?api_key=Did1TB2wePuugtO71ukMOxwrAx5CGaiR&limit=20&rating=g");
    // "https://api.giphy.com/v1/gifs/trending?api_key=ku2ccWtCSKi6ZrC2XePc08FfIeDbMWx1&limit=20&rating=g");

    var url2 = Uri.parse(
        //https://api.giphy.com/v1/gifs/search?api_key=Did1TB2wePuugtO71ukMOxwrAx5CGaiR&q=dogs&limit=20&offset=0&rating=g&lang=en
        //"https://api.giphy.com/v1/gifs/search?api_key=ku2ccWtCSKi6ZrC2XePc08FfIeDbMWx1&q=$_search&limit=19&offset=$_offset&rating=g&lang=pt");

        "https://api.giphy.com/v1/gifs/search?api_key=Did1TB2wePuugtO71ukMOxwrAx5CGaiR&q=$_search&limit=19&offset=$_offset&rating=g&lang=en");

    if (_search == null || _search!.isEmpty) {
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
            //GIPHY + GATO
            "https://media4.giphy.com/media/l41YlHs99JsSptZf2/200w.webp?cid=ecf05e47tlmbf5bvtdljjl8bz8k8ah12cgcd7yj7getx1dp6&rid=200w.webp&ct=g"),
        //GIPHY DEVELOPER
        // "https://developers.giphy.com/branch/master/static/header-logo-0fec0225d189bc0eae27dac3e3770582.gif"),
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
                "Este projeto foi criado como um experimento de aprendizado. \n\nEste App efetua uso e consumo de duas APIs diferentes. A primeira API dos gifs mais bem avaliados no momento de sua consulta e a segunda dos gifs procurados. \n\nNovas funcionalidades como o compartilhamento em redes sociais e plataformas de comunicação estarão disponiveis em breve.",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 18),
              ),
            ),
            ListTile(
              title: Text(
                "\nObrigado por sua visualização.",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: "Pesquise Aqui!",
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
              onSubmitted: (text) {
                setState(() {
                  _search = text;
                  _offset = 0;
                });
              },
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
                    if (snapshot.hasError) {
                      return Container(color: Colors.red);
                    } else {
                      return _createGifTable(context, snapshot);
                    }
                }
              },
            ),
          )
        ],
      ),
    );
  }

  int _getCount(List data) {
    if (_search == null) {
      return data.length;
    } else {
      return data.length + 1;
    }
  }

  Widget _createGifTable(BuildContext context, AsyncSnapshot snapshot) {
    //Widget _createGifTable(context, snapshot) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        //expações entre os gifs, formadores do grid
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      shrinkWrap: true,
      itemCount: _getCount(snapshot.data["data"]),
      itemBuilder: (context, index) {
        if (_search == null || index < snapshot.data['data'].length) {
          return GestureDetector(
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: snapshot.data["data"][index]["images"]["fixed_height"]
                  ["url"],
              height: 300.0,
              fit: BoxFit.cover,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        GifPage(snapshot.data["data"][index])),
              );
            },
            onLongPress: () {
              Share.share(snapshot.data["data"][index]["images"]["fixed_height"]
                  ["url"]);
            },
          );
        } else {
          return GestureDetector(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Icon(Icons.add, color: Colors.white, size: 70),
                Text("Carregar mais...", style: TextStyle(color: Colors.white))
              ],
            ),
            onTap: () {
              setState(() {
                _offset += 19;
              });
            },
          );
        }
      },
    );
  }
}
