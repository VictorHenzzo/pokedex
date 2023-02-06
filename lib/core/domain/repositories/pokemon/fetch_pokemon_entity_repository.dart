import 'package:pokedex/core/domain/entities/pokemon/pokemon_entity.dart';
import 'package:pokedex/core/errors/app_error.dart';
import 'package:result_dart/result_dart.dart';

abstract class IFetchPokemonRepository {
  Future<Result<PokemonEntity, AppError>> fetchPokemon(
    final String pokemonUrl,
  );
}
