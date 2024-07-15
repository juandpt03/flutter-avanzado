import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/home_provider.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeProvider>().state;

    return AppBar(
      title: state.mapOrNull(
        success: (success) => Text(
          success.wsStatus.when(
            connecting: () => 'Connecting...',
            connected: () => 'Connected',
            failed: () => 'Failed',
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
