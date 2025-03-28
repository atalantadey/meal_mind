import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'di/dependency_injection.dart';
import 'presentation/screens/login_screen.dart';
import 'presentation/theme/app_theme.dart';

void main() {
  init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: appTheme(), home: const LoginScreen());
  }
}
