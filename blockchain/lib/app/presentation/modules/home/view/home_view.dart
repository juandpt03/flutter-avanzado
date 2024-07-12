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
        wsRepository: context.read(),
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
            failed: (error) {
              return error.when(
                network: () => const Center(
                  child: Text('Network error'),
                ),
                notFound: () => const Center(
                  child: Text('Not found'),
                ),
                server: () => const Center(
                  child: Text('Server error'),
                ),
                unauthorized: () => const Center(
                  child: Text('Unauthorized'),
                ),
                badRequest: () => const Center(
                  child: Text('Bad request'),
                ),
                local: () => const Center(
                  child: Text('Local error'),
                ),
              );
            },
            success: (cryptos, _) => ListView.builder(
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
