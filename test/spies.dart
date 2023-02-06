import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/core/adapters/http/remote_data_source.dart';
import 'package:pokedex/core/domain/entities/pokemon/pokemon_entity.dart';
import 'package:pokedex/core/errors/app_error.dart';

class RemoteDataSourceSpy extends Mock implements RemoteDatasource {}

class HttpClientMock extends Mock implements Client {}

PokemonEntity pokemonMock() {
  return PokemonEntity(
    name: 'name',
    height: 1,
    weight: 1,
    moves: [],
    sprite: 'sprite',
    specieUrl: 'specieUrl',
    types: [],
  );
}

AppError appErrorMock() {
  return AppError(
    stackTrace: StackTrace.empty,
    message: 'message',
    statusCode: 400,
    exception: Exception(),
  );
}
