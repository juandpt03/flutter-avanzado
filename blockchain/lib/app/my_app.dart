import 'package:flutter/material.dart';

import '../config/theme/app_theme.dart';
import 'presentation/modules/home/view/home_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blockchain',
      theme: AppTheme().theme,
      home: const HomeView(),
    );
  }
}
