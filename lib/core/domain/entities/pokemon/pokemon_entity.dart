import 'package:pokedex/core/domain/entities/move/move_entity.dart';
import 'package:pokedex/core/domain/entities/pokemon/pokemon_type_entity.dart';

class PokemonEntity {
  PokemonEntity({
    required this.name,
    required this.height,
    required this.weight,
    required this.moves,
    required this.sprite,
    required this.specieUrl,
    required this.types,
  });

  final String name;
  final double height;
  final double weight;
  final List<MoveEntity> moves;
  final String sprite;
  final String specieUrl;
  final List<PokemonTypeEntity> types;
}
