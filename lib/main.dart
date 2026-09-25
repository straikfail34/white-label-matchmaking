import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/config/supabase_config.dart';
import 'app.dart';

void main() async {
  // Garantiza que los bindings del framework estén listos antes de ejecutar código asíncrono.
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicialización de la conexión con el backend.
  await SupabaseConfig.initialize();

  // Ejecución de la aplicación envuelta en ProviderScope para Riverpod.
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}