class AppError {
  final String message;
  final int? statusCode;
  final Exception exception;
  final StackTrace stackTrace;

  AppError({
    required this.stackTrace,
    required this.message,
    required this.statusCode,
    required this.exception,
  });
}
