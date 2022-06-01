import 'package:flutter/cupertino.dart';
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding:
                  EdgeInsets.only(top: 95, left: 20, right: 20, bottom: 20),
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
                    const SizedBox(height: 95),
                    Padding(padding: EdgeInsets.only(top: 100)),
                    Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        "${data.name}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      decoration: new BoxDecoration(
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 10, bottom: 10, right: 20, left: 20),
                      // child: descriptionsText(false, "${data.name}".toUpperCase(), 30, true),
                      child: descriptionsText(
                          false,
                          "Height: " +
                              "${data.height! / 10}m | "
                                  "Weight: ${data.weight! / 10}kg",
                          18,
                          false),
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15.0),
                            bottomRight: Radius.circular(15.0)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      padding: EdgeInsets.only(top: 18),
                      width: 80,
                      height: 70,
                      child: Text(
                        "${data.baseExperience}",
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100.0),
                          border: Border.all(
                            color: Colors.black,
                            width: 3.0,
                          )),
                    ),
                    Text(
                      "Login dulu untuk melihat informasi yang lebih lengkap!",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 25),
                  ],
                ),
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

  Widget _buildSuccessSection(DetailPokemonModel data) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 10),
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding:
                    EdgeInsets.only(top: 95, left: 20, right: 20, bottom: 20),
                child: Column(
                  children: [
                    Card(
                      elevation: 15.0,
                      color: Colors
                          .primaries[Random().nextInt(Colors.primaries.length)],
                      shadowColor: Colors
                          .primaries[Random().nextInt(Colors.primaries.length)],
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.elliptical(15, 15),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox(height: 95),
                          Padding(padding: EdgeInsets.only(top: 100)),
                          Container(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              "${data.name}".toUpperCase(),
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            decoration: new BoxDecoration(
                              color: Colors.black,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                top: 10, bottom: 10, right: 20, left: 20),
                            // child: descriptionsText(false, "${data.name}".toUpperCase(), 30, true),
                            child: descriptionsText(
                                false,
                                "Height: " +
                                    "${data.height! / 10}m | "
                                        "Weight: ${data.weight! / 10}kg",
                                18,
                                false),
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0)),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            padding: EdgeInsets.only(top: 18),
                            width: 80,
                            height: 70,
                            child: Text(
                              "${data.baseExperience}",
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            decoration: new BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100.0),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 3.0,
                                )),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            margin:
                                EdgeInsets.only(top: 20, left: 50, right: 50),
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              "ABILITIES",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            decoration: new BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0)),
                            ),
                          ),
                          Container(
                            height: 70,
                            margin: EdgeInsets.only(left: 50, right: 50),
                            width: MediaQuery.of(context).size.width,
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 60,
                                mainAxisSpacing: 0,
                                crossAxisSpacing: 0,
                              ),
                              itemCount: data.abilities?.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Center(
                                  child: Container(
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    padding:
                                        EdgeInsets.only(top: 12, bottom: 8),
                                    height: 40,
                                    width: 120,
                                    decoration: new BoxDecoration(
                                        color: Color(0xFF354259),
                                        borderRadius: BorderRadius.circular(7)),
                                    child: Text(
                                      "${data.abilities?[index].ability!.name}"
                                          .toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0)),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            margin:
                                EdgeInsets.only(top: 20, left: 50, right: 50),
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              "TYPES",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            decoration: new BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0)),
                            ),
                          ),
                          Container(
                            height: 70,
                            margin: EdgeInsets.only(left: 50, right: 50),
                            width: MediaQuery.of(context).size.width,
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 60,
                                mainAxisSpacing: 0,
                                crossAxisSpacing: 0,
                              ),
                              itemCount: data.types?.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Center(
                                  child: Container(
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    padding:
                                        EdgeInsets.only(top: 12, bottom: 8),
                                    height: 40,
                                    width: 120,
                                    decoration: new BoxDecoration(
                                        color: Color(0xFF354259),
                                        borderRadius: BorderRadius.circular(7)),
                                    child: Text(
                                      "${data.types?[index].type!.name}"
                                          .toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0)),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            margin:
                                EdgeInsets.only(top: 20, left: 50, right: 50),
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              "STATS",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            decoration: new BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0)),
                            ),
                          ),
                          Container(
                            height: 300,
                            margin: EdgeInsets.only(
                                left: 50, right: 50, bottom: 20),
                            width: MediaQuery.of(context).size.width,
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                mainAxisExtent: 60,
                                mainAxisSpacing: 0,
                                crossAxisSpacing: 0,
                              ),
                              itemCount: data.stats?.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Center(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        top: 5, bottom: 5, left: 10, right: 10),
                                    padding: EdgeInsets.only(
                                        top: 12,
                                        bottom: 8,
                                        left: 10,
                                        right: 10),
                                    height: 40,
                                    width: 180,
                                    decoration: new BoxDecoration(
                                        color: Color(0xFF354259),
                                        borderRadius: BorderRadius.circular(7)),
                                    child: Text(
                                      "${data.stats?[index].stat!.name} : ${data.stats?[index].baseStat}"
                                          .toUpperCase(),
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0)),
                            ),
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
