import 'package:pokedex/core/domain/entities/pokemon/pokemon_pagination_entity.dart';
import 'package:pokedex/core/errors/app_error.dart';
import 'package:result_dart/result_dart.dart';

abstract class IFetchPokemonPaginationRepository {
  Future<Result<PokemonPaginationEntity, AppError>> fetchPokemonPagination({
    final PokemonPaginationEntity? pokemonPaginationEntity,
  });
}
