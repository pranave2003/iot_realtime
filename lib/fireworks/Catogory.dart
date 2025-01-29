import 'package:flutter/material.dart';

import 'fireworks.dart';

class Catogory extends StatefulWidget {
  const Catogory({super.key});

  @override
  State<Catogory> createState() => _CatogoryState();
}

class _CatogoryState extends State<Catogory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return Fireworks();
                },
              ));
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text("Catogory"),
      ),
    );
  }
}
