import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/home_provider.dart';
import 'widgets/app_bar.dart';
import 'widgets/error.dart';
import 'widgets/loaded.dart';

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
          body: CustomScrollView(
            slivers: [
              const HomeSliverAppbar(),
              homeProvider.state.map<Widget>(
                loading: (_) => const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator())),
                failed: (_) => const HomeError(),
                success: (_) => const HomeLoaded(),
              ),
            ],
          ),
        );
      },
    );
  }
}
