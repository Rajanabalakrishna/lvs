import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lvt/feautres/auth/presentation/screens/login_screen.dart';
import 'package:lvt/feautres/home/presentation/screens/home_screen.dart';
import 'package:lvt/feautres/auth/presentation/notifier/auth_notifier.dart';
import 'package:lvt/feautres/auth/presentation/state/auth_state.dart';
import 'firebase_options.dart';
import 'splash_screen.dart';

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

    return MaterialApp(
      title: 'LVS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: authState.when(
        initial: () => const LoadingScreen(),
        loading: () => const LoadingScreen(),
        authenticated: (user) => HomeScreen(user: user),
        unauthenticated: () => const LoginScreen(),
        error: (msg) => const LoginScreen(),
      ),
    );
  }
}
