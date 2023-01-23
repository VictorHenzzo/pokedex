import 'package:equatable/equatable.dart';

abstract class HttpError extends Equatable implements Exception {
  int get statusCode;
  String get errorMessage;
}

class NotFoundError extends HttpError {
  @override
  final String errorMessage;

  @override
  final int statusCode = 404;

  NotFoundError(this.errorMessage);

  @override
  List<Object?> get props => [statusCode];
}

class BadRequestError extends HttpError {
  @override
  final String errorMessage;

  @override
  final int statusCode = 400;

  BadRequestError(this.errorMessage);

  @override
  List<Object?> get props => [statusCode];
}

class ServerError extends HttpError {
  @override
  final String errorMessage;

  @override
  final int statusCode = 500;

  ServerError(this.errorMessage);

  @override
  List<Object?> get props => [statusCode];
}
