import 'package:cached_network_image/cached_network_image.dart';
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
      success: (success) => SliverList.separated(
        itemCount: success.cryptos.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final crypto = success.cryptos[index];

          return ListTile(
            contentPadding: const EdgeInsets.all(10),
            leading: CachedNetworkImage(
              width: 30,
              imageUrl:
                  'https://assets.coincap.io/assets/icons/${crypto.symbol.toLowerCase()}@2x.png',
              errorWidget: (context, url, error) {
                return const Icon(
                  Icons.image_not_supported_outlined,
                  size: 30,
                );
              },
            ),
            title: Text(crypto.name),
            subtitle: Text(crypto.symbol),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  NumberFormat.simpleCurrency(decimalDigits: 3)
                      .format(double.tryParse(crypto.priceUsd)),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(
                  '${NumberFormat.decimalPatternDigits(decimalDigits: 4).format(double.tryParse(crypto.changePercent24Hr))}%',
                  style: TextStyle(
                    color: (double.tryParse(crypto.changePercent24Hr) ?? 0) < 0
                        ? Colors.red
                        : Colors.green,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      orElse: () => const SliverToBoxAdapter(child: SizedBox()),
    );
  }
}
