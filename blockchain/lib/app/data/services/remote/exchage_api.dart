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
        throw const HttpRequestFailure.badRequest();
      }

      if (response.statusCode == 200) {
        final cryptos = Cryptos.fromJson(response.data);
        return Either.right(cryptos.cryptos);
      }

      if (response.statusCode == 404) {
        throw const HttpRequestFailure.notFound();
      }

      if (response.statusCode! >= 500) {
        throw const HttpRequestFailure.server();
      }

      throw const HttpRequestFailure.local();
    } catch (e) {
      late HttpRequestFailure failure;
      if (e is HttpRequestFailure) {
        failure = e;
      } else if (e is DioException || e is SocketException) {
        failure = const HttpRequestFailure.network();
      } else {
        failure = const HttpRequestFailure.local();
      }

      return Either.left(failure);
    }
  }
}
