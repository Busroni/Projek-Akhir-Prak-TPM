import 'dart:html';

import 'package:flutter/material.dart';
import 'model/pokemon_list_model.dart';
import 'pokemon_data_source.dart';
import 'detail_pokemon.dart';

class PageListPokemon extends StatefulWidget {
  const PageListPokemon({Key? key}) : super(key: key);

  @override
  _PageListPokemonState createState() => _PageListPokemonState();
}

class _PageListPokemonState extends State<PageListPokemon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildListPokemonBody(),
    );
  }

  Widget _buildListPokemonBody() {
    return Container(
      child: FutureBuilder(
        future: PokemonDataSource.instance.loadPokemonList(),
        builder: (
            BuildContext context,
            AsyncSnapshot<dynamic> snapshot,
            ) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            PokemonListModel pokemonListModel =
            PokemonListModel.fromJson(snapshot.data);
            return _buildSuccessSection(pokemonListModel);
            // return _buildPokemonData(pokemonListModel);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildEmptySection() {
    return Text("Empty");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(PokemonListModel data) {
    return SafeArea(
      child: Column(
        children: [
          Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          Text("Pokemon",
            style: TextStyle(fontSize: 30,
              fontWeight: FontWeight.bold,
            color: Colors.blue,letterSpacing: 10),
          ),
          Container(
            padding: EdgeInsets.only(top: 20),
            height: 650,
            child: ListView.builder(
            itemCount: data.results?.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return DetailPokemon(
                        pokemonName: "${data.results?[index].name}",
                      );
                    }));
                  },
                  child: _buildItemPokemonList("${data.results?[index].name}"),
                );
                // return _buildItemCountries("${data.results?[index].name}");
              },
            ),
          ),
        ],
      )

    );
  }

  Widget _buildItemPokemonList(String name) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [

            Text(
              '${name}',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
