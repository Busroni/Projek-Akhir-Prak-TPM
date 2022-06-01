import 'package:flutter/material.dart';
import 'detail_pokemon.dart';
import 'model/pokemon_color_species_model.dart';
import 'pokemon_data_source.dart';
import 'model/detail_pokemon_model.dart';
import 'dart:math';

class PageColorListPokemon extends StatefulWidget {
  final String pokemonColor;
  final bool isLogin;

  const PageColorListPokemon(
      {Key? key, required this.pokemonColor, required this.isLogin})
      : super(key: key);

  @override
  _PageColorListPokemonState createState() => _PageColorListPokemonState();
}

class _PageColorListPokemonState extends State<PageColorListPokemon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokemon ${widget.pokemonColor}"),
      ),
      body: SingleChildScrollView(
        child: _buildDetailPokemonBody(),
      ),
    );
  }

  Widget _buildDetailPokemonBody() {
    return Container(
      child: FutureBuilder(
        future:
        PokemonDataSource.instance.loadPokemonColorSpecies(widget.pokemonColor),
        builder: (
            BuildContext context,
            AsyncSnapshot<dynamic> snapshot,
            ) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            PokemonColorSpeciesModel pokemonColorSpeciesModel =
            PokemonColorSpeciesModel.fromJson(snapshot.data);
            return _buildSuccessSection(pokemonColorSpeciesModel);
            // _buildAbilitiesSection(detailPokemonModel);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(PokemonColorSpeciesModel data) {
    return SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 20),
              height: 780,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    childAspectRatio: 2 / 2.3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: data.pokemonSpecies!.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return DetailPokemon(
                          pokemonName: "${data.pokemonSpecies?[index].name}", isLogin: widget.isLogin,
                        );
                      }));
                    },
                    //child: _buildItemPokemonList("${data.results?[index].name}"),
                    child: _buildViewPokemonList("${data.pokemonSpecies?[index].name}"),
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
