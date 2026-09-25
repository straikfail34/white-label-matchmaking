import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static late final SupabaseClient client;

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: 'https://jqfmkciahsfstzansztg.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpxZm1rY2lhaHNmc3R6YW5zenRnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3OTAzNDg3MDAsImV4cCI6MjEwNTkyNDcwMH0.RKlbYSSkLgsIswmKxWyzJkeMb-hIzN6v2-wBo67K_SY',
    );
    client = Supabase.instance.client;
  }
}