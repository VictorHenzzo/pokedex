import 'package:pokedex/core/domain/entities/pokemon/pokemon_entity.dart';
import 'package:pokedex/core/domain/repositories/pokemon/fetch_pokemon_entity_repository.dart';
import 'package:pokedex/core/errors/app_error.dart';
import 'package:result_dart/result_dart.dart';

abstract class IFetchPokemonEntityUseCase {
  Future<Result<PokemonEntity, AppError>> fetchPokemon(
    final String pokemonUrl,
  );
}

class FetchPokemonUseCase implements IFetchPokemonEntityUseCase {
  FetchPokemonUseCase(this.repository);

  final IFetchPokemonRepository repository;

  @override
  Future<Result<PokemonEntity, AppError>> fetchPokemon(String pokemonUrl) {
    return repository.fetchPokemon(pokemonUrl);
  }
}
