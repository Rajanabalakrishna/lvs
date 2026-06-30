import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lvt/feautres/auth/presentation/notifier/auth_notifier.dart';
import 'package:lvt/feautres/auth/presentation/state/auth_state.dart';
import 'package:lvt/feautres/home/presentation/screens/home_screen.dart';
import 'package:lvt/splash_screen.dart';
import 'firebase_options.dart';
import 'feautres/auth/presentation/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);

    Widget home;
    if (authState is AuthLoading || authState is AuthInitial) {
      home = const LoadingScreen();
    } else if (authState is AuthAuthenticated) {
      home = HomeScreen(user: (authState as AuthAuthenticated).user);
    } else {
      home = const LoginScreen();
    }

    return MaterialApp(
      title: 'LVS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: home,
    );
  }
}
