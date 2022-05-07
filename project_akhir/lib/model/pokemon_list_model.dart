class PokemonListModel {
  int? count;
  String? next;
  dynamic previous;
  List<Results>? results;

  PokemonListModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  PokemonListModel.fromJson(Map<String, dynamic> json) {
    count = json['count'] as int?;
    next = json['next'] as String?;
    previous = json['previous'];
    results = (json['results'] as List?)?.map((dynamic e) => Results.fromJson(e as Map<String,dynamic>)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['count'] = count;
    json['next'] = next;
    json['previous'] = previous;
    json['results'] = results?.map((e) => e.toJson()).toList();
    return json;
  }
}

class Results {
  String? name;
  String? url;

  Results({
    this.name,
    this.url,
  });

  Results.fromJson(Map<String, dynamic> json) {
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