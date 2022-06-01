import 'dart:math';

import 'package:flutter/material.dart';
import 'package:loginregisterlocaldata/page_color_list.dart';
import 'model/detail_pokemon_model.dart';
import 'model/pokemon_color_model.dart';
import 'model/pokemon_list_model.dart';
import 'pokemon_data_source.dart';
import 'detail_pokemon.dart';

class PageListPokemon extends StatefulWidget {
  final bool isLogin;

  const PageListPokemon({Key? key, required this.isLogin}) : super(key: key);

  @override
  _PageListPokemonState createState() => _PageListPokemonState();
}

class _PageListPokemonState extends State<PageListPokemon> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        child: Column(
          children: [
            _buildListPokemonColor(),
            _buildListPokemonBody()
          ],
        ),
      ),
    );
  }

  Widget _buildListPokemonBody() {
    _buildListPokemonColor();
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
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildListPokemonColor(){
    return Container(
      child: FutureBuilder(
        future: PokemonDataSource.instance.loadPokemonColor(),
        builder: (
            BuildContext context,
            AsyncSnapshot<dynamic> snapshot,
            ) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            PokemonColorModel pokemonColorModel =
            PokemonColorModel.fromJson(snapshot.data);
            return _buildColorSuccessSection(pokemonColorModel);
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
  }//

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
  Widget _buildColorSuccessSection(PokemonColorModel data){
    return SizedBox(
      height: 50,
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: data.results?.length ,
        itemBuilder: (BuildContext context, int index){
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PageColorListPokemon(
                    pokemonColor: "${data.results?[index].name}", isLogin: widget.isLogin,
                  );
                }));
              },
              child: _buildViewColorPokemonList("${data.results?[index].name}"),
            );
        },
      )
    );
  }

  Widget _buildViewColorPokemonList(String name){
    return Container(
      width: 100,
      child: Card(
        color: Colors.blue,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text("${name}".toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 16
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessSection(PokemonListModel data) {

    return SafeArea(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 5),
            height: 730,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300,
              childAspectRatio: 2 / 2.3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
              itemCount: data.results?.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return DetailPokemon(
                        pokemonName: "${data.results?[index].name}", isLogin: widget.isLogin,
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
                      width: 180,
                      height: 180,
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

}
