import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/core/adapters/http/http_data_source_adapter.dart';
import 'package:pokedex/core/errors/http_error.dart';

import '../../../spies.dart';

void main() {
  late HttpDataSourceAdapter sut;
  late HttpClientMock clientMock;

  const url = 'example';
  final uri = Uri.parse('https://pokeapi.co/api/v2/$url');
  final response = http.Response('body', 200);
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

    test('should throw BadRequestError on 400', () async {
      // arrange
      when(() => clientMock.get(uri)).thenAnswer(
        (final _) async => http.Response('', 400),
      );

      // act
      final result = sut.get(url: url);

      // assert
      expect(result, throwsA(BadRequestError('')));
    });

    test('should throw NotFoundError on 404', () async {
      // arrange
      when(() => clientMock.get(uri)).thenAnswer(
        (final _) async => http.Response('', 404),
      );

      // act
      final result = sut.get(url: url);

      // assert
      expect(result, throwsA(NotFoundError('')));
    });

    test('should throw ServerError if statusCode is none of above', () async {
      // arrange
      when(() => clientMock.get(uri)).thenAnswer(
        (final _) async => http.Response('', 500),
      );

      // act
      final result = sut.get(url: url);

      // assert
      expect(result, throwsA(ServerError('')));
    });
  });
}
