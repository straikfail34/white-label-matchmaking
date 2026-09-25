import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/config/supabase_config.dart';
import '../models/profile_model.dart';

final discoveryRepositoryProvider = Provider<DiscoveryRepository>((ref) {
  return DiscoveryRepository(SupabaseConfig.client);
});

class DiscoveryRepository {
  final SupabaseClient _client;

  DiscoveryRepository(this._client);

  Future<List<ProfileModel>> getProfilesToSwipe() async {
    final currentUserId = _client.auth.currentUser?.id;
    if (currentUserId == null) return [];

    // Consulta estricta: extrae perfiles excluyendo al usuario actual
    // En producción se requiere filtrar IDs ya interactuados en la tabla 'swipes'
    final response = await _client
        .from('profiles')
        .select()
        .neq('id', currentUserId)
        .limit(15);
        
    return (response as List).map((json) => ProfileModel.fromJson(json)).toList();
  }
  
  Future<void> registerSwipe({required String toUserId, required String action}) async {
    final currentUserId = _client.auth.currentUser?.id;
    if (currentUserId == null) return;

    await _client.from('swipes').insert({
      'from_user_id': currentUserId,
      'to_user_id': toUserId,
      'action': action,
    });
  }
}