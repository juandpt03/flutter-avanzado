import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/home_provider.dart';

class HomeSliverAppbar extends StatelessWidget {
  const HomeSliverAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeProvider>().state;
    final colors = Theme.of(context).colorScheme;

    return SliverAppBar(
      backgroundColor: colors.primary,
      title: Text(
        'Crypto Tracker',
        style: TextStyle(
          color: colors.onPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
      floating: true,
      snap: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: state.mapOrNull(
                success: (success) => Row(
                  children: [
                    success.wsStatus.when(
                      connecting: () =>
                          Icon(Icons.hourglass_empty, color: colors.onPrimary),
                      connected: () =>
                          const Icon(Icons.check_circle, color: Colors.green),
                      failed: () => const Icon(Icons.error, color: Colors.red),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      success.wsStatus.when(
                        connecting: () => 'Connecting...',
                        connected: () => 'Connected',
                        failed: () => 'Failed',
                      ),
                      style: TextStyle(
                        color: colors.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ) ??
              Container(),
        ),
      ],
    );
  }
}
