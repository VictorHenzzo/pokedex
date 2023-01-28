import 'package:pokedex/core/domain/entities/pokemon/pokemon_pagination_entity.dart';
import 'package:pokedex/core/infra/errors/app_error.dart';
import 'package:result_dart/result_dart.dart';

abstract class IFetchPokemonPaginationRepository {
  Future<Result<PokemonPaginationEntity, AppError>> fetch({
    final PokemonPaginationEntity? pokemonPaginationEntity,
  });
}
