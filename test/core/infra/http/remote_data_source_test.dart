import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/core/infra/http/http_data_source_adapter.dart';

import '../../../spies.dart';

void main() {
  late HttpDataSourceAdapter sut;
  late HttpClientMock clientMock;

  const url = 'example';
  final uri = Uri.parse('https://pokeapi.co/api/v2/$url');
  final response = Response('body', 200);
  const headers = {'key': 'values'};

  setUp(() {
    clientMock = HttpClientMock();

    sut = HttpDataSourceAdapter(
      clientMock,
    );
  });

  group('get', () {
    test('should be able to call client.get', () async {
      // arrange
      when(() => clientMock.get(uri)).thenAnswer(
        (invocation) async => response,
      );

      // act
      await sut.get(url: url);

      // assert
      verify(() => clientMock.get(uri)).called(1);
    });

    test('should be able to call client.get with the correct values', () async {
      // arrange
      when(() => clientMock.get(
            uri,
            headers: headers,
          )).thenAnswer(
        (invocation) async => response,
      );

      // act
      await sut.get(
        url: url,
        headers: headers,
      );

      // assert
      verify(
        () => clientMock.get(
          uri,
          headers: headers,
        ),
      ).called(1);
    });

    test('should be able to return a Response', () async {
      // arrange
      when(() => clientMock.get(uri)).thenAnswer(
        (invocation) async => response,
      );

      // act
      final result = await sut.get(url: url);

      // assert
      expect(result.body, 'body');
      expect(result.statusCode, 200);
    });
  });
}
