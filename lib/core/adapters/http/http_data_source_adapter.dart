import 'package:http/http.dart' as http;
import 'package:pokedex/core/errors/http_error.dart';
import 'package:pokedex/core/adapters/http/remote_data_source.dart';

class HttpDataSourceAdapter implements RemoteDatasource {
  final http.Client client;

  HttpDataSourceAdapter(this.client);

  @override
  Future<Response> get({
    required String url,
    Map<String, String>? headers,
  }) async {
    final uri = Uri.parse(url);

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
