import 'package:http/http.dart' as http;
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

    return Response(
      body: httpResponse.body,
      statusCode: httpResponse.statusCode,
    );
  }
}
