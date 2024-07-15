import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/home_provider.dart';

class HomeError extends StatelessWidget {
  const HomeError({super.key});

  @override
  Widget build(BuildContext context) {
    final home = context.watch<HomeProvider>();

    final state = home.state;

    return state.maybeWhen(
      failed: (error) => error.when(
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
      ),
      orElse: () => const Text('Unknown error'),
    );
  }
}
