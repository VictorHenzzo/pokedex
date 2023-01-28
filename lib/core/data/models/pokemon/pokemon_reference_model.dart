import 'package:pokedex/core/domain/entities/pokemon/pokemon_reference_entity.dart';

class PokemonReferenceModel {
  const PokemonReferenceModel({
    required this.name,
    required this.url,
  });

  final String name;
  final String url;

  factory PokemonReferenceModel.fromJson(Map<String, dynamic> json) {
    return PokemonReferenceModel(
      name: json['name'],
      url: json['url'],
    );
  }

  PokemonReferenceEntity toEntity() {
    return PokemonReferenceEntity(
      name: name,
      url: url,
    );
  }
}
