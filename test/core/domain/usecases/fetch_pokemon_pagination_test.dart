import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/core/domain/entities/pokemon/pokemon_pagination_entity.dart';
import 'package:pokedex/core/domain/repositories/pokemon/fetch_pokemon_pagination.dart';
import 'package:pokedex/core/domain/usecases/pokemon/fetch_pokemon_pagination.dart';
import 'package:pokedex/core/infra/errors/app_error.dart';
import 'package:result_dart/result_dart.dart';

void main() {
  late IFetchPokemonPaginationUseCase sut;
  late IFetchPokemonPaginationRepository repository;

  const pokemonPaginationEntity = PokemonPaginationEntity(
    next: null,
    previous: null,
    pokemonReferences: [],
  );
  final appError = AppError(
    message: 'Failure',
    statusCode: 0,
    exception: Exception(),
    stackTrace: StackTrace.empty,
  );

  setUp(() {
    repository = _FetchPokemonRepository();
    sut = FetchPokemonPaginationUseCase(repository);
  });

  test('should be able to call repository', () async {
    // arrange
    when(repository.fetchPokemonPagination).thenAnswer(
      (final _) async => const Success(pokemonPaginationEntity),
    );

    // act
    sut.fetch();

    // assert
    verify(repository.fetchPokemonPagination).called(1);
  });

  test('should be able to call repository with the correct values', () async {
    // arrange
    when(
      () => repository.fetchPokemonPagination(
        pokemonPaginationEntity: pokemonPaginationEntity,
      ),
    ).thenAnswer((final _) async => const Success(pokemonPaginationEntity));

    // act
    sut.fetch(
      pokemonPaginationEntity: pokemonPaginationEntity,
    );

    // assert
    verify(
      () => repository.fetchPokemonPagination(
        pokemonPaginationEntity: pokemonPaginationEntity,
      ),
    ).called(1);
  });

  test('should be able to return a PokemonPaginationEntity on success', () async {
    // arrange
    when(
      () => repository.fetchPokemonPagination(
        pokemonPaginationEntity: pokemonPaginationEntity,
      ),
    ).thenAnswer((final _) async => const Success(pokemonPaginationEntity));

    when(repository.fetchPokemonPagination).thenAnswer(
      (final _) async => const Success(pokemonPaginationEntity),
    );

    // act
    final answerWithParams = await sut.fetch(
      pokemonPaginationEntity: pokemonPaginationEntity,
    );

    final answerWithoutParams = await sut.fetch();

    // assert
    expect(answerWithParams.getOrNull(), isA<PokemonPaginationEntity>());
    expect(answerWithoutParams.getOrNull(), isA<PokemonPaginationEntity>());
  });

  test('should be able to return a AppError on failure', () async {
    // arrange
    when(
      () => repository.fetchPokemonPagination(
        pokemonPaginationEntity: pokemonPaginationEntity,
      ),
    ).thenAnswer((final _) async => Failure(appError));

    when(repository.fetchPokemonPagination).thenAnswer(
      (final _) async => Failure(appError),
    );

    // act
    final answerWithParams = await sut.fetch(
      pokemonPaginationEntity: pokemonPaginationEntity,
    );

    final answerWithoutParams = await sut.fetch();

    // assert
    expect(answerWithParams.exceptionOrNull(), isA<AppError>());
    expect(answerWithoutParams.exceptionOrNull(), isA<AppError>());
  });
}

class _FetchPokemonRepository extends Mock implements IFetchPokemonPaginationRepository {}
