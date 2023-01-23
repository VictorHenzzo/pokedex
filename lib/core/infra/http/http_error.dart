abstract class HttpError implements Exception {
  int get statusCode;
  String get errorMessage;
}

class NotFoundError implements HttpError {
  @override
  final String errorMessage;

  @override
  final int statusCode;

  NotFoundError(this.errorMessage, this.statusCode);
}
