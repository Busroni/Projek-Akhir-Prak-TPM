class PokemonColorModel {
  final int? count;
  final dynamic next;
  final dynamic previous;
  final List<Results>? results;

  PokemonColorModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  PokemonColorModel.fromJson(Map<String, dynamic> json)
      : count = json['count'] as int?,
        next = json['next'],
        previous = json['previous'],
        results = (json['results'] as List?)?.map((dynamic e) => Results.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'count' : count,
    'next' : next,
    'previous' : previous,
    'results' : results?.map((e) => e.toJson()).toList()
  };
}

class Results {
  final String? name;
  final String? url;

  Results({
    this.name,
    this.url,
  });

  Results.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        url = json['url'] as String?;

  Map<String, dynamic> toJson() => {
    'name' : name,
    'url' : url
  };
}