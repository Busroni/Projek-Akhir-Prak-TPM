class DetailPokemonModel {
  List<Abilities>? abilities;
  int? baseExperience;
  List<Forms>? forms;
  int? height;
  List<dynamic>? heldItems;
  int? id;
  bool? isDefault;
  String? locationAreaEncounters;
  String? name;
  int? order;
  List<dynamic>? pastTypes;
  Species? species;
  List<Stats>? stats;
  List<Types>? types;
  int? weight;

  DetailPokemonModel({
    this.abilities,
    this.baseExperience,
    this.forms,
    this.height,
    this.heldItems,
    this.id,
    this.isDefault,
    this.locationAreaEncounters,
    this.name,
    this.order,
    this.pastTypes,
    this.species,
    this.stats,
    this.types,
    this.weight,
  });

  DetailPokemonModel.fromJson(Map<String, dynamic> json) {
    abilities = (json['abilities'] as List?)?.map((dynamic e) => Abilities.fromJson(e as Map<String,dynamic>)).toList();
    baseExperience = json['base_experience'] as int?;
    forms = (json['forms'] as List?)?.map((dynamic e) => Forms.fromJson(e as Map<String,dynamic>)).toList();
    height = json['height'] as int?;
    heldItems = json['held_items'] as List?;
    id = json['id'] as int?;
    isDefault = json['is_default'] as bool?;
    locationAreaEncounters = json['location_area_encounters'] as String?;
    name = json['name'] as String?;
    order = json['order'] as int?;
    pastTypes = json['past_types'] as List?;
    species = (json['species'] as Map<String,dynamic>?) != null ? Species.fromJson(json['species'] as Map<String,dynamic>) : null;
    stats = (json['stats'] as List?)?.map((dynamic e) => Stats.fromJson(e as Map<String,dynamic>)).toList();
    types = (json['types'] as List?)?.map((dynamic e) => Types.fromJson(e as Map<String,dynamic>)).toList();
    weight = json['weight'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['abilities'] = abilities?.map((e) => e.toJson()).toList();
    json['base_experience'] = baseExperience;
    json['forms'] = forms?.map((e) => e.toJson()).toList();
    json['height'] = height;
    json['held_items'] = heldItems;
    json['id'] = id;
    json['is_default'] = isDefault;
    json['location_area_encounters'] = locationAreaEncounters;
    json['name'] = name;
    json['order'] = order;
    json['past_types'] = pastTypes;
    json['species'] = species?.toJson();
    json['stats'] = stats?.map((e) => e.toJson()).toList();
    json['types'] = types?.map((e) => e.toJson()).toList();
    json['weight'] = weight;
    return json;
  }
}

class Abilities {
  Ability? ability;
  bool? isHidden;
  int? slot;

  Abilities({
    this.ability,
    this.isHidden,
    this.slot,
  });

  Abilities.fromJson(Map<String, dynamic> json) {
    ability = (json['ability'] as Map<String,dynamic>?) != null ? Ability.fromJson(json['ability'] as Map<String,dynamic>) : null;
    isHidden = json['is_hidden'] as bool?;
    slot = json['slot'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['ability'] = ability?.toJson();
    json['is_hidden'] = isHidden;
    json['slot'] = slot;
    return json;
  }
}

class Ability {
  String? name;
  String? url;

  Ability({
    this.name,
    this.url,
  });

  Ability.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    url = json['url'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['name'] = name;
    json['url'] = url;
    return json;
  }
}

class Forms {
  String? name;
  String? url;

  Forms({
    this.name,
    this.url,
  });

  Forms.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    url = json['url'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['name'] = name;
    json['url'] = url;
    return json;
  }
}

class Species {
  String? name;
  String? url;

  Species({
    this.name,
    this.url,
  });

  Species.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    url = json['url'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['name'] = name;
    json['url'] = url;
    return json;
  }
}

class Stats {
  int? baseStat;
  int? effort;
  Stat? stat;

  Stats({
    this.baseStat,
    this.effort,
    this.stat,
  });

  Stats.fromJson(Map<String, dynamic> json) {
    baseStat = json['base_stat'] as int?;
    effort = json['effort'] as int?;
    stat = (json['stat'] as Map<String,dynamic>?) != null ? Stat.fromJson(json['stat'] as Map<String,dynamic>) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['base_stat'] = baseStat;
    json['effort'] = effort;
    json['stat'] = stat?.toJson();
    return json;
  }
}

class Stat {
  String? name;
  String? url;

  Stat({
    this.name,
    this.url,
  });

  Stat.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    url = json['url'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['name'] = name;
    json['url'] = url;
    return json;
  }
}

class Types {
  int? slot;
  Type? type;

  Types({
    this.slot,
    this.type,
  });

  Types.fromJson(Map<String, dynamic> json) {
    slot = json['slot'] as int?;
    type = (json['type'] as Map<String,dynamic>?) != null ? Type.fromJson(json['type'] as Map<String,dynamic>) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['slot'] = slot;
    json['type'] = type?.toJson();
    return json;
  }
}

class Type {
  String? name;
  String? url;

  Type({
    this.name,
    this.url,
  });

  Type.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    url = json['url'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['name'] = name;
    json['url'] = url;
    return json;
  }
}