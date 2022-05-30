import 'package:flutter/material.dart';
import 'pokemon_data_source.dart';
import 'model/detail_pokemon_model.dart';
import 'dart:math';

class DetailPokemon extends StatefulWidget {
  final String pokemonName;
  final bool isLogin;

  const DetailPokemon(
      {Key? key, required this.pokemonName, required this.isLogin})
      : super(key: key);

  @override
  _DetailPokemonState createState() => _DetailPokemonState();
}

class _DetailPokemonState extends State<DetailPokemon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.pokemonName}"),
      ),
      body: _buildDetailPokemonBody(),
    );
  }

  Widget _buildDetailPokemonBody() {
    return Container(
      child: FutureBuilder(
        future:
            PokemonDataSource.instance.loadPokemonDetail(widget.pokemonName),
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
            return widget.isLogin == true
                ? _buildSuccessSection(detailPokemonModel)
                : _buildLimitSuccessSection(detailPokemonModel);
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

  Widget _buildLimitSuccessSection(DetailPokemonModel data) {
    return SafeArea(
      child: Stack(
        children: [
          Positioned(
            height: MediaQuery.of(context).size.height / 1.3,
            width: MediaQuery.of(context).size.width - 20,
            top: MediaQuery.of(context).size.height * 0.1,
            left: 10,
            child: Card(
              elevation: 15.0,
              color:
                  Colors.primaries[Random().nextInt(Colors.primaries.length)],
              shadowColor:
                  Colors.primaries[Random().nextInt(Colors.primaries.length)],
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.elliptical(15, 15),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(height: 70),
                  Padding(padding: EdgeInsets.only(top: 50)),
                  descriptionsText(
                      false, "${data.name}".toUpperCase(), 30, true),
                  descriptionsText(
                      false,
                      "Height: " +
                          "${data.height!/10}m | "
                              "Weight: ${data.weight!/10}kg",
                      18,
                      false),
                  Text(
                    "Login dulu untuk melihat informasi yang lebih lengkap!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Image.network(
              "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${data.id}.png",
              width: 400,
              height: 400,
              fit: BoxFit.fill,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSuccessSection(DetailPokemonModel data) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Stack(
          children: [
            Positioned(
              height: MediaQuery.of(context).size.height / 1.3,
              width: MediaQuery.of(context).size.width - 20,
              top: MediaQuery.of(context).size.height * 0.1,
              left: 10,
              child: Column(
                children: [
                  Card(
                    elevation: 15.0,
                    color:
                        Colors.primaries[Random().nextInt(Colors.primaries.length)],
                    shadowColor:
                        Colors.primaries[Random().nextInt(Colors.primaries.length)],
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.elliptical(15, 15),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(height: 70),
                        Padding(padding: EdgeInsets.only(top: 100)),
                        descriptionsText(
                            false, "${data.name}".toUpperCase(), 30, true),
                        descriptionsText(
                            false,
                            "Height: " +
                                "${data.height!/10}m | "
                                    "Weight: ${data.weight!/10}kg",
                            18,
                            false),
                        Padding(
                          padding: EdgeInsets.only(top:20),
                          child: descriptionsText(false, "Ability".toUpperCase(), 20, true),
                        ),
                        Container(
                          height: 50,
                          child: ListView.builder(
                              itemCount: data.abilities?.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Center(
                                    child: Text(
                                        "${data.abilities?[index].ability!.name}"));
                              }),
                        ),
                        descriptionsText(
                            false,
                            "Base Experience : " + "${data.baseExperience}",
                            20,
                            true),
                        Padding(
                          padding: EdgeInsets.only(top:15),
                          child: descriptionsText(false, "Stat".toUpperCase(), 20, true),
                        ),
                        Container(
                          height: 100,
                          child: ListView.builder(
                              itemCount: data.stats?.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Center(
                                    child: Text(
                                        "${data.stats?[index].stat!.name} : ${data.stats?[index].baseStat}"));
                              }),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top:15),
                          child: descriptionsText(false, "Types".toUpperCase(), 20, true),
                        ),
                        Container(
                          height: 100,
                          child: ListView.builder(
                              itemCount: data.types?.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Center(
                                    child: Text("${data.types?[index].type!.name}"));
                              }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Image.network(
                "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${data.id}.png",
                width: 270,
                height: 270,
                fit: BoxFit.fill,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget descriptionsText(
      bool _isContainer, String _textContent, double fontSize, bool _isBold) {
    return _isContainer
        ? Container(
            width: 90,
            decoration: const BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Center(
              child: Text(
                _textContent,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: _isBold ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          )
        : Text(
            _textContent,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: _isBold ? FontWeight.bold : FontWeight.normal,
            ),
          );
  }
}
