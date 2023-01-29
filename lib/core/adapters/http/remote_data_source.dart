abstract class RemoteDatasource {
  Future<Response> get({
    required String url,
    Map<String, String>? headers,
  });
}

class Response {
  final String body;
  final int statusCode;

  Response({
    required this.body,
    required this.statusCode,
  });
}
