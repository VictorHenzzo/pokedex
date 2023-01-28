import 'package:pokedex/core/data/models/pokemon/pokemon_reference_model.dart';
import 'package:pokedex/core/domain/entities/pokemon/pokemon_pagination_entity.dart';
import 'package:pokedex/core/domain/entities/pokemon/pokemon_reference_entity.dart';

class PokemonPaginationModel {
  PokemonPaginationModel({
    required this.next,
    required this.previous,
    required this.pokemonReferences,
  });

  final String? next;
  final String? previous;
  final List<PokemonReferenceEntity> pokemonReferences;

  factory PokemonPaginationModel.fromJson(final Map<String, dynamic> json) {
    final jsonPokemonReferences = json['results'] as List;
    final pokemonReferenceEntities = jsonPokemonReferences.map((final pokemon) {
      return PokemonReferenceModel.fromJson(pokemon).toEntity();
    }).toList(growable: false);

    return PokemonPaginationModel(
      next: json['next'],
      previous: json['previous'],
      pokemonReferences: pokemonReferenceEntities,
    );
  }

  PokemonPaginationEntity toEntity() {
    return PokemonPaginationEntity(
      next: next,
      previous: previous,
      pokemonReferences: pokemonReferences,
    );
  }
}
