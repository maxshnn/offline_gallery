import 'package:dio/dio.dart';

class BadRequest extends DioException {
  BadRequest({
    required super.requestOptions,
    required super.message,
  });
}

class Forbidden extends DioException {
  Forbidden({
    required super.requestOptions,
    required super.message,
  });
}

class NotFound extends DioException {
  NotFound({
    required super.requestOptions,
    required super.message,
  });
}

class Conflict extends DioException {
  Conflict({
    required super.requestOptions,
    required super.message,
  });
}

class UnprocessableContent extends DioException {
  UnprocessableContent({
    required super.requestOptions,
    required super.message,
  });
}

class TooManyRequests extends DioException {
  TooManyRequests({
    required super.requestOptions,
    required super.message,
  });
}

class ServerUnavailable extends DioException {
  ServerUnavailable({
    required super.requestOptions,
    required super.message,
  });
}

class ServerTemporarilyUnavailable extends DioException {
  ServerTemporarilyUnavailable({
    required super.requestOptions,
    required super.message,
  });
}

class UnknownError extends DioException {
  UnknownError({
    required super.requestOptions,
    required super.message,
  });
}
  