import 'dart:convert';

import 'package:pokedex/core/data/models/pokemon/pokemon_pagination_model.dart';
import 'package:pokedex/core/domain/entities/pokemon/pokemon_pagination_entity.dart';
import 'package:pokedex/core/domain/repositories/pokemon/fetch_pokemon_pagination.dart';
import 'package:pokedex/core/errors/app_error.dart';
import 'package:pokedex/core/errors/http_error.dart';
import 'package:pokedex/core/adapters/http/remote_data_source.dart';
import 'package:result_dart/result_dart.dart';

class PokemonRepository implements IFetchPokemonPaginationRepository {
  PokemonRepository(this.dataSource);

  final RemoteDatasource dataSource;
  final String _baseUrl = 'https://pokeapi.co/api/v2/pokemon';

  @override
  Future<Result<PokemonPaginationEntity, AppError>> fetchPokemonPagination({
    PokemonPaginationEntity? pokemonPaginationEntity,
  }) async {
    final currentUrl = pokemonPaginationEntity?.next ?? _baseUrl;

    try {
      final result = await dataSource.get(url: currentUrl);
      final json = jsonDecode(result.body);

      final pokemonPagination = PokemonPaginationModel.fromJson(json).toEntity();

      return Success(pokemonPagination);
    } on HttpError catch (ex, stackTrace) {
      return Failure(
        AppError(
          exception: ex,
          statusCode: ex.statusCode,
          message: ex.errorMessage,
          stackTrace: stackTrace,
        ),
      );
    }
  }
}
