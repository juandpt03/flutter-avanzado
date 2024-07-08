import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/home_provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(
        exchangeRepository: context.read(),
      ),
      builder: (context, _) {
        final HomeProvider homeProvider = context.watch();

        return Scaffold(
          appBar: AppBar(
            title: const Text('Cryptos'),
          ),
          body: homeProvider.state.when<Widget>(
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            failed: (message) {
              return Center(
                child: Text(message),
              );
            },
            success: (cryptos) => ListView.builder(
              itemCount: cryptos.length,
              itemBuilder: (context, index) {
                final crypto = cryptos[index];

                return ListTile(
                  title: Text(crypto.name),
                  subtitle: Text(crypto.symbol),
                  trailing: Text(
                    NumberFormat.simpleCurrency()
                        .format(double.tryParse(crypto.priceUsd)),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
