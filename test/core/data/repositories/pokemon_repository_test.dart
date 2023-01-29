import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/core/data/repositories/pokemon_repository.dart';
import 'package:pokedex/core/domain/entities/pokemon/pokemon_pagination_entity.dart';
import 'package:pokedex/core/errors/app_error.dart';
import 'package:pokedex/core/errors/http_error.dart';
import 'package:pokedex/core/adapters/http/remote_data_source.dart';

import '../../../spies.dart';

void main() {
  late PokemonRepository sut;
  late RemoteDataSourceSpy dataSource;

  const String baseUrl = 'https://pokeapi.co/api/v2/pokemon';
  const String customUrl = 'custom-url';

  const pokemonPaginationEntity = PokemonPaginationEntity(
    next: customUrl,
    previous: 'previous',
    pokemonReferences: [],
  );

  final successResponse = Response(
    body:
        r'{"count":1279,"next":"https://pokeapi.co/api/v2/pokemon?offset=20&limit=20","previous":null,"results":[{"name":"bulbasaur","url":"https://pokeapi.co/api/v2/pokemon/1/"},{"name":"ivysaur","url":"https://pokeapi.co/api/v2/pokemon/2/"},{"name":"venusaur","url":"https://pokeapi.co/api/v2/pokemon/3/"},{"name":"charmander","url":"https://pokeapi.co/api/v2/pokemon/4/"},{"name":"charmeleon","url":"https://pokeapi.co/api/v2/pokemon/5/"},{"name":"charizard","url":"https://pokeapi.co/api/v2/pokemon/6/"},{"name":"squirtle","url":"https://pokeapi.co/api/v2/pokemon/7/"},{"name":"wartortle","url":"https://pokeapi.co/api/v2/pokemon/8/"},{"name":"blastoise","url":"https://pokeapi.co/api/v2/pokemon/9/"},{"name":"caterpie","url":"https://pokeapi.co/api/v2/pokemon/10/"},{"name":"metapod","url":"https://pokeapi.co/api/v2/pokemon/11/"},{"name":"butterfree","url":"https://pokeapi.co/api/v2/pokemon/12/"},{"name":"weedle","url":"https://pokeapi.co/api/v2/pokemon/13/"},{"name":"kakuna","url":"https://pokeapi.co/api/v2/pokemon/14/"},{"name":"beedrill","url":"https://pokeapi.co/api/v2/pokemon/15/"},{"name":"pidgey","url":"https://pokeapi.co/api/v2/pokemon/16/"},{"name":"pidgeotto","url":"https://pokeapi.co/api/v2/pokemon/17/"},{"name":"pidgeot","url":"https://pokeapi.co/api/v2/pokemon/18/"},{"name":"rattata","url":"https://pokeapi.co/api/v2/pokemon/19/"},{"name":"raticate","url":"https://pokeapi.co/api/v2/pokemon/20/"}]}',
    statusCode: 200,
  );

  setUp(() {
    dataSource = RemoteDataSourceSpy();
    sut = PokemonRepository(dataSource);
  });

  group('Fetch pokemon pagination', () {
    test('Should be able to call datasource', () async {
      // arrange
      when(() => dataSource.get(
            url: baseUrl,
          )).thenAnswer(
        (final _) async => successResponse,
      );

      // act
      sut.fetchPokemonPagination();

      // assert
      verify(
        () => dataSource.get(
          url: baseUrl,
        ),
      ).called(1);
    });

    test('Should be call custom url if arguments were given', () async {
      // arrange
      when(() => dataSource.get(
            url: customUrl,
          )).thenAnswer(
        (final _) async => successResponse,
      );

      // act
      sut.fetchPokemonPagination(
        pokemonPaginationEntity: pokemonPaginationEntity,
      );

      // assert
      verify(
        () => dataSource.get(
          url: customUrl,
        ),
      ).called(1);
    });

    test('should be able to return a PokemonPaginationEntity on success', () async {
      // arrange
      when(() => dataSource.get(
            url: baseUrl,
          )).thenAnswer(
        (final _) async => successResponse,
      );

      // act
      final result = await sut.fetchPokemonPagination();

      // assert
      expect(result.getOrNull(), isA<PokemonPaginationEntity>());
    });

    test('should be able to return AppError if datasource throws', () async {
      // arrange
      when(() => dataSource.get(
            url: baseUrl,
          )).thenThrow(
        NotFoundError('errorMessage'),
      );

      // act
      final response = await sut.fetchPokemonPagination();

      // assert
      expect(response.exceptionOrNull(), isA<AppError>());
    });
  });
}
