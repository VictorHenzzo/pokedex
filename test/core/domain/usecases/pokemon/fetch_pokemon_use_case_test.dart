import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/core/domain/entities/pokemon/pokemon_entity.dart';
import 'package:pokedex/core/domain/repositories/pokemon/fetch_pokemon_entity_repository.dart';
import 'package:pokedex/core/domain/usecases/pokemon/fetch_pokemon_use_case.dart';
import 'package:result_dart/src/result.dart';
import 'package:pokedex/core/errors/app_error.dart';

import '../../../../spies.dart';

void main() {
  late IFetchPokemonEntityUseCase sut;
  late IFetchPokemonRepository repository;

  final pokemon = pokemonMock();
  final appError = appErrorMock();

  setUp(() {
    repository = _IFetchPokemonRepository();
    sut = FetchPokemonUseCase(repository);
  });

  test('should be able to call repository', () async {
    // arrange
    when(() => repository.fetchPokemon(any())).thenAnswer(
      (final _) async => Success(pokemon),
    );

    // act
    await sut.fetchPokemon('pokemonUrl');

    // assert
    verify(() => repository.fetchPokemon('pokemonUrl')).called(1);
  });

  test('should be able to return a pokemon on success', () async {
    // arrange
    when(() => repository.fetchPokemon(any())).thenAnswer(
      (final _) async => Success(pokemon),
    );

    // act
    final result = await sut.fetchPokemon('pokemonUrl');

    // assert
    expect(result.getOrNull(), isA<PokemonEntity>());
  });

  test('should be able to return a error no failure', () async {
    // arrange
    when(() => repository.fetchPokemon(any())).thenAnswer(
      (final _) async => Failure(appError),
    );

    // act
    final result = await sut.fetchPokemon('pokemonUrl');

    // assert
    expect(result.exceptionOrNull(), isA<AppError>());
  });
}

class _IFetchPokemonRepository extends Mock implements IFetchPokemonRepository {}
