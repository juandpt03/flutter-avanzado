import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'app/data/repositories_impl/exchange_repository_impl.dart';
import 'app/data/services/remote/exchage_api.dart';
import 'app/domain/repositories/exchange_repository.dart';
import 'app/my_app.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<ExchangeRepository>(
          create: (_) => ExchangeRepositoryImpl(
            api: ExchangeAPI(
              client: Dio(),
            ),
          ),
        )
      ],
      child: const MyApp(),
    ),
  );
}
