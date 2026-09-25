import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/config/supabase_config.dart';
import 'features/discovery/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicialización de la base de datos
  await SupabaseConfig.initialize();

  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Matchmaking App',
      theme: ThemeData.dark(), // Tema oscuro base para contraste
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}