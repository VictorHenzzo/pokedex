import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/core/infra/http/remote_data_source.dart';

class RemoteDataSourceSpy extends Mock implements RemoteDatasource {}

class HttpClientMock extends Mock implements Client {}
