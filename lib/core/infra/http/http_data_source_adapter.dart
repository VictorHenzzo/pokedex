import 'package:http/http.dart' as http;
import 'package:pokedex/core/infra/http/http_error.dart';
import 'package:pokedex/core/infra/http/remote_data_source.dart';

class HttpDataSourceAdapter implements RemoteDatasource {
  final http.Client client;

  HttpDataSourceAdapter(this.client);

  String get _baseUrl => 'https://pokeapi.co/api/v2/';

  @override
  Future<Response> get({
    required String url,
    Map<String, String>? headers,
  }) async {
    final uri = Uri.parse(_baseUrl + url);

    final httpResponse = await client
        .get(
          uri,
          headers: headers,
        )
        .timeout(
          const Duration(seconds: 10),
        );

    return _handleResponse(httpResponse);
  }
}

Response _handleResponse(http.Response httpResponse) {
  switch (httpResponse.statusCode) {
    case 200:
    case 201:
    case 204:
      return Response(
        body: httpResponse.body,
        statusCode: httpResponse.statusCode,
      );
    case 400:
      throw BadRequestError(httpResponse.body);
    case 404:
      throw NotFoundError(httpResponse.body);
    default:
      throw ServerError(httpResponse.body);
  }
}
