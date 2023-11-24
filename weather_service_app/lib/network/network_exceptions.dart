// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_exceptions.freezed.dart';

@freezed
abstract class NetworkExceptions with _$NetworkExceptions {
  const factory NetworkExceptions.requestCancelled() = RequestCancelled;

  const factory NetworkExceptions.unauthorisedRequest() = UnauthorisedRequest;

  const factory NetworkExceptions.badRequest() = BadRequest;

  const factory NetworkExceptions.notFound(String reason) = NotFound;

  const factory NetworkExceptions.methodNotAllowed() = MethodNotAllowed;

  const factory NetworkExceptions.notAcceptable() = NotAcceptable;

  const factory NetworkExceptions.requestTimeout() = RequestTimeout;

  const factory NetworkExceptions.sendTimeout() = SendTimeout;

  const factory NetworkExceptions.conflict() = Conflict;

  const factory NetworkExceptions.internalServerError() = InternalServerError;

  const factory NetworkExceptions.notImplemented() = NotImplemented;

  const factory NetworkExceptions.serviceUnavailable() = ServiceUnavailable;

  const factory NetworkExceptions.noInternetConnection() = NoInternetConnection;

  const factory NetworkExceptions.formatException() = FormatException;

  const factory NetworkExceptions.unableToProcess() = UnableToProcess;

  const factory NetworkExceptions.defaultError(String error) = DefaultError;

  const factory NetworkExceptions.unexpectedError() = UnexpectedError;

  static NetworkExceptions getDioException(error) {
    if (error is Exception) {
      try {
        NetworkExceptions networkExceptions;
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.cancel:
              networkExceptions = const NetworkExceptions.requestCancelled();
              break;
            case DioErrorType.connectionTimeout:
              networkExceptions = const NetworkExceptions.requestTimeout();
              break;
            case DioErrorType.connectionError:
              networkExceptions =
                  const NetworkExceptions.noInternetConnection();
              break;
            case DioErrorType.receiveTimeout:
              networkExceptions = const NetworkExceptions.sendTimeout();
              break;
            case DioErrorType.badResponse:
              switch (error.response?.statusCode) {
                case 400:
                  networkExceptions =
                      const NetworkExceptions.unauthorisedRequest();
                  break;
                case 401:
                  networkExceptions =
                      const NetworkExceptions.unauthorisedRequest();
                  break;
                case 403:
                  networkExceptions =
                      const NetworkExceptions.unauthorisedRequest();
                  break;
                case 404:
                  networkExceptions =
                      const NetworkExceptions.notFound("Город не найден");
                  break;
                case 409:
                  networkExceptions = const NetworkExceptions.conflict();
                  break;
                case 408:
                  networkExceptions = const NetworkExceptions.requestTimeout();
                  break;
                case 500:
                  networkExceptions =
                      const NetworkExceptions.internalServerError();
                  break;
                case 503:
                  networkExceptions =
                      const NetworkExceptions.serviceUnavailable();
                  break;
                default:
                  var responseCode = error.response?.statusCode;
                  networkExceptions = NetworkExceptions.defaultError(
                    "Received invalid status code: $responseCode",
                  );
              }
              break;
            case DioErrorType.sendTimeout:
              networkExceptions = const NetworkExceptions.sendTimeout();
              break;
            default:
              networkExceptions =
                  const NetworkExceptions.noInternetConnection();
              break;
          }
        } else if (error is SocketException) {
          networkExceptions = const NetworkExceptions.noInternetConnection();
        } else {
          networkExceptions = const NetworkExceptions.unexpectedError();
        }
        return networkExceptions;
      } on FormatException {
        return const NetworkExceptions.formatException();
      } catch (_) {
        return const NetworkExceptions.unexpectedError();
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        return const NetworkExceptions.unableToProcess();
      } else {
        return const NetworkExceptions.unexpectedError();
      }
    }
  }

  static String getErrorMessage(NetworkExceptions networkExceptions) {
    var errorMessage = "";
    networkExceptions.when(
      notImplemented: () {
      errorMessage = "Не реализовано";
    }, requestCancelled: () {
      errorMessage = "Запрос отменен";
    }, internalServerError: () {
      errorMessage = "внутренняя ошибка сервера";
    }, notFound: (String reason) {
      errorMessage = reason;
    }, serviceUnavailable: () {
      errorMessage = "Услуга недоступна";
    }, methodNotAllowed: () {
      errorMessage = "Метод не разрешен";
    }, badRequest: () {
      errorMessage = "Bad request";
    }, unauthorisedRequest: () {
      errorMessage = "Пустое поле";
    }, unexpectedError: () {
      errorMessage = "Произошла непредвиденная ошибка";
    }, requestTimeout: () {
      errorMessage = "Тайм-аут запроса на подключение";
    }, noInternetConnection: () {
      errorMessage = "Нет подключения к Интернету";
    }, conflict: () {
      errorMessage = "Ошибка из-за конфликта";
    }, sendTimeout: () {
      errorMessage = "Тайм-аут отправки в соединении с API-сервером";
    }, unableToProcess: () {
      errorMessage = "Не удается обработать данные";
    }, defaultError: (String error) {
      errorMessage = error;
    }, formatException: () {
      errorMessage = "Произошла непредвиденная ошибка";
    }, notAcceptable: () {
      errorMessage = "Произошла непредвиденная ошибка";
    }
     );
    return errorMessage;
  }
}




/* // ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';

class DioExceptions implements Exception {
late String message;

DioExceptions.fromDioError(DioError dioError) {
  switch (dioError.type) {
    case DioErrorType.connectionError:
      message = "LOST CONNECTION connectionError";
      break;    
    case DioErrorType.cancel:
      message = "Request to API server was cancelled";
      break;
    case DioErrorType.connectionTimeout:
      message = "Connection timeout with API server";
      break;
    case DioErrorType.receiveTimeout:
      message = "Receive timeout in connection with API server";
      break;
    case DioErrorType.badResponse:
      message = _handleError(
        dioError.response?.statusCode,
        dioError.response?.data,
      );
      break;
    case DioErrorType.sendTimeout:
      message = "Send timeout in connection with API server";
      break;
    
    case DioErrorType.unknown:
      if (dioError.message?.contains("SocketException") ?? false) {
        message = 'No Internet';
        break;
      }
      message = "Unexpected error occurred";
      break;
    default:
      message = "Something went wrong";
      break;
  }
}

String _handleError(int? statusCode, dynamic error) {
  switch (statusCode) {
    case 400:
      return 'Bad request';
    case 401:
      return 'Unauthorized';
    case 403:
      return 'Forbidden';
    case 404:
      return error['message'];
    case 500:
      return 'Internal server error';
    case 502:
      return 'Bad gateway';
    default:
      return 'Oops something went wrong';
  }
}

@override
String toString() => message;
} */


/* // ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:dio/dio.dart';

enum NetworkErrorType {
  requestCancelled,
  requestTimeout,
  noInternetConnection,
  sendTimeout,
  receiveTimeout,
  unauthorisedRequest,
  unknown,
  notFound,
  internalServerError,
  serviceUnavailable,
  somethingWrong,
  formatException,
  unexpectedError,
}

class NetworkError {
  NetworkErrorType getDioError(error) {
    NetworkErrorType networkErrorType;
    if (error is Exception) {
      try {
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.cancel:
              networkErrorType = NetworkErrorType.requestCancelled;
              break;
            case DioErrorType.connectionTimeout:
              networkErrorType = NetworkErrorType.requestTimeout;
              break;
            case DioErrorType.receiveTimeout:
              networkErrorType = NetworkErrorType.receiveTimeout;
              break;
            case DioErrorType.sendTimeout:
              networkErrorType = NetworkErrorType.sendTimeout;
              break;
            case DioErrorType.badResponse:
              switch (error.response!.statusCode) {
                case 400:
                  networkErrorType = NetworkErrorType.unauthorisedRequest;
                  break;
                case 401:
                  networkErrorType = NetworkErrorType.unauthorisedRequest;
                  break;
                case 403:
                  networkErrorType = NetworkErrorType.unauthorisedRequest;
                  break;
                case 404:
                  networkErrorType = NetworkErrorType.notFound;
                  break;
                case 500:
                  networkErrorType = NetworkErrorType.internalServerError;
                  break;
                case 503:
                  networkErrorType = NetworkErrorType.serviceUnavailable;
                  break;
                default:
                  networkErrorType = NetworkErrorType.somethingWrong;
                  break;
              }
              break;
            case DioErrorType.unknown:
              networkErrorType = NetworkErrorType.noInternetConnection;
              break;
            case DioExceptionType.badCertificate:
              // TODO: Handle this case.
            case DioExceptionType.connectionError:
              // TODO: Handle this case.
          }
        } else if (error is SocketException) {
          networkErrorType = NetworkErrorType.noInternetConnection;
        } else {
          networkErrorType = NetworkErrorType.somethingWrong;
        }
        return networkErrorType;
      } on FormatException catch (e) {
        networkErrorType = NetworkErrorType.formatException;
      } catch (_) {
        networkErrorType = NetworkErrorType.unexpectedError;
      }
    } else {
      networkErrorType = NetworkErrorType.somethingWrong;
    }
    return networkErrorType;
  }
} */