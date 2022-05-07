import 'base_network.dart';

class PokemonDataSource {
  static PokemonDataSource instance = PokemonDataSource();

  Future<Map<String, dynamic>> loadPokemonList() {
    return BaseNetwork.get("pokemon?limit=1126&offset=0");
  }

  Future<Map<String, dynamic>> loadPokemonDetail(pokemonName) {
    return BaseNetwork.get("pokemon/${pokemonName}");
  }
}