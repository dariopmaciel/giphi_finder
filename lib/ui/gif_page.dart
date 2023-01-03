import 'package:flutter/material.dart';
import 'package:share/share.dart';

class GifPage extends StatelessWidget {
  final Map _gifData;

  const GifPage(this._gifData, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Voltar"),
        backgroundColor: Colors.black,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: CircleAvatar(
              backgroundColor: Colors.blue,
              child: IconButton(
                  onPressed: () {
                    //do the thing
                    Share.share(_gifData["images"]["downsized_large"]["url"]);
                  },
                  icon: const Icon(
                    Icons.share,
                    color: Colors.white,
                  )),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              height: 350,
              width: 400,
              color: Colors.blue,
              child: Center(
                child:
                    Image.network(_gifData["images"]["downsized_large"]["url"]),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
              height: 200,
              width: 450,
              color: Colors.red,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      "Titulo: ",
                      style: TextStyle(fontSize: 22, color: Colors.white),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      _gifData["title"],
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
