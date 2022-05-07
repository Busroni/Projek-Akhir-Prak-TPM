import 'package:flutter/material.dart';
import 'package:loginregisterlocaldata/page_list_pokemon.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '123190142 & 123190142',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PageListPokemon(),
    );
  }
}