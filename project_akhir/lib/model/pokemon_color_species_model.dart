class PokemonColorSpeciesModel {
  final int? id;
  final String? name;
  final List<Names>? names;
  final List<PokemonSpecies>? pokemonSpecies;

  PokemonColorSpeciesModel({
    this.id,
    this.name,
    this.names,
    this.pokemonSpecies,
  });

  PokemonColorSpeciesModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        names = (json['names'] as List?)?.map((dynamic e) => Names.fromJson(e as Map<String,dynamic>)).toList(),
        pokemonSpecies = (json['pokemon_species'] as List?)?.map((dynamic e) => PokemonSpecies.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'names' : names?.map((e) => e.toJson()).toList(),
    'pokemon_species' : pokemonSpecies?.map((e) => e.toJson()).toList()
  };
}

class Names {
  final Language? language;
  final String? name;

  Names({
    this.language,
    this.name,
  });

  Names.fromJson(Map<String, dynamic> json)
      : language = (json['language'] as Map<String,dynamic>?) != null ? Language.fromJson(json['language'] as Map<String,dynamic>) : null,
        name = json['name'] as String?;

  Map<String, dynamic> toJson() => {
    'language' : language?.toJson(),
    'name' : name
  };
}

class Language {
  final String? name;
  final String? url;

  Language({
    this.name,
    this.url,
  });

  Language.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        url = json['url'] as String?;

  Map<String, dynamic> toJson() => {
    'name' : name,
    'url' : url
  };
}

class PokemonSpecies {
  final String? name;
  final String? url;

  PokemonSpecies({
    this.name,
    this.url,
  });

  PokemonSpecies.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        url = json['url'] as String?;

  Map<String, dynamic> toJson() => {
    'name' : name,
    'url' : url
  };
}