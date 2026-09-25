import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static const String _url = 'https://jqfmkciahsfstzansztg.supabase.co';
  static const String _anonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpxZm1rY2lhaHNmc3R6YW5zenRnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3OTAzNDg3MDAsImV4cCI6MjEwNTkyNDcwMH0.RKlbYSSkLgsIswmKxWyzJkeMb-hIzN6v2-wBo67K_SY';

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: _url,
      anonKey: _anonKey,
    );
  }

  static SupabaseClient get client => Supabase.instance.client;
}