import 'package:pokedex/core/domain/entities/pokemon/pokemon_reference_entity.dart';

class PokemonPaginationEntity {
  const PokemonPaginationEntity({
    required this.next,
    required this.previous,
    required this.pokemonReferences,
  });

  final String? next;
  final String? previous;
  final List<PokemonReferenceEntity> pokemonReferences;
}
