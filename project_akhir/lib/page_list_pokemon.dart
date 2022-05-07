import 'dart:math';

import 'package:flutter/material.dart';
import 'model/detail_pokemon_model.dart';
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
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300,
              childAspectRatio: 2 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
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
                  //child: _buildItemPokemonList("${data.results?[index].name}"),
                  child: _buildViewPokemonList("${data.results?[index].name}"),
                );
                // return _buildItemCountries("${data.results?[index].name}");
              },
            ),
          ),
        ],
      )

    );
  }

  Widget _buildViewPokemonList(String name) {
    return Container(
      child: FutureBuilder(
        future:
        PokemonDataSource.instance.loadPokemonDetail(name),
        builder: (
            BuildContext context,
            AsyncSnapshot<dynamic> snapshot,
            ) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            DetailPokemonModel detailPokemonModel =
            DetailPokemonModel.fromJson(snapshot.data);
            return _buildViewImagePokemonList(detailPokemonModel);
            // _buildAbilitiesSection(detailPokemonModel);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildViewImagePokemonList(DetailPokemonModel detail){
    return SafeArea(
        child: Card(
            elevation: 5.0,
            shadowColor:
            Colors.primaries[Random().nextInt(Colors.primaries.length)],
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.elliptical(15, 15),
              ),
            ),
            child: Container(
                  child: Column(
                  children: [
                    Image.network(
                    "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${detail.id}.png",
                      width: 200,
                      height: 200,
                      fit: BoxFit.fill,
                    ),
                    Text("${detail.name}", style: TextStyle(
                      fontSize:20,
                    ),)
                  ],
            ),
          ),
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
