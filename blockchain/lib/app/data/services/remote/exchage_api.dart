import 'dart:io';

import 'package:dio/dio.dart';

import '../../../domain/either/either.dart';
import '../../../domain/failures/http_request_failure.dart';
import '../../../domain/models/crypto/crypto.dart';
import '../../../domain/repositories/exchange_repository.dart';

class ExchangeAPI {
  final Dio client;
  ExchangeAPI({required this.client});

  GetPricesFuture getPrices() async {
    try {
      final response = await client.get('https://api.coincap.io/v2/assets');

      if (response.statusCode == null) {
        throw HttpRequestFailure.badRequest;
      }

      if (response.statusCode == 200) {
        final cryptos = Cryptos.fromJson(response.data);
        return Right(cryptos.cryptos);
      }

      if (response.statusCode == 404) {
        throw HttpRequestFailure.notFound;
      }

      if (response.statusCode! >= 500) {
        throw HttpRequestFailure.server;
      }

      throw HttpRequestFailure.local;
    } catch (e) {
      late HttpRequestFailure failure;
      if (e is HttpRequestFailure) {
        failure = e;
      } else if (e is DioException || e is SocketException) {
        failure = HttpRequestFailure.network;
      } else {
        failure = HttpRequestFailure.local;
      }

      return Left(failure);
    }
  }
}
