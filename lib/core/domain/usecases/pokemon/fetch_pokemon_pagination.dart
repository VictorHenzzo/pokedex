import 'package:pokedex/core/domain/entities/pokemon/pokemon_pagination_entity.dart';
import 'package:pokedex/core/domain/repositories/pokemon/fetch_pokemon_pagination.dart';
import 'package:pokedex/core/infra/errors/app_error.dart';
import 'package:result_dart/result_dart.dart';

abstract class IFetchPokemonPaginationUseCase {
  Future<Result<PokemonPaginationEntity, AppError>> fetch({
    final PokemonPaginationEntity? pokemonPaginationEntity,
  });
}

class FetchPokemonPaginationUseCase implements IFetchPokemonPaginationUseCase {
  FetchPokemonPaginationUseCase(this.repository);

  final IFetchPokemonPaginationRepository repository;

  @override
  Future<Result<PokemonPaginationEntity, AppError>> fetch({
    final PokemonPaginationEntity? pokemonPaginationEntity,
  }) {
    return repository.fetch(
      pokemonPaginationEntity: pokemonPaginationEntity,
    );
  }
}
