class AppError {
  final String message;
  final int? statusCode;
  final Exception exception;

  AppError({
    required this.message,
    required this.statusCode,
    required this.exception,
  });
}
