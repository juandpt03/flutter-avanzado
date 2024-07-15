import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/home_provider.dart';

class HomeLoaded extends StatelessWidget {
  const HomeLoaded({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeProvider>().state;

    return state.maybeMap(
      success: (success) => ListView.builder(
        itemCount: success.cryptos.length,
        itemBuilder: (context, index) {
          final crypto = success.cryptos[index];

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
      orElse: () => const SizedBox(),
    );
  }
}
