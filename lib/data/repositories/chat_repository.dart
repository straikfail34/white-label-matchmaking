import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/config/supabase_config.dart';
import '../models/match_model.dart';
import '../models/message_model.dart';
import '../models/profile_model.dart';

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  return ChatRepository(SupabaseConfig.client);
});

class ChatRepository {
  final SupabaseClient _client;

  ChatRepository(this._client);

  Future<List<MatchModel>> getMatches() async {
    final currentUserId = _client.auth.currentUser?.id;
    if (currentUserId == null) return [];

    final response = await _client
        .from('matches')
        .select()
        .contains('users', [currentUserId]);

    List<MatchModel> matches = [];
    for (var item in response) {
      final users = List<String>.from(item['users']);
      final otherUserId = users.firstWhere((id) => id != currentUserId);
      
      final profileResponse = await _client
          .from('profiles')
          .select()
          .eq('id', otherUserId)
          .single();

      final profile = ProfileModel.fromJson(profileResponse);
      matches.add(MatchModel.fromJson(item, matchedUser: profile));
    }
    return matches;
  }

  Stream<List<MessageModel>> getMessagesStream(String matchId) {
    return _client
        .from('messages')
        .stream(primaryKey: ['id'])
        .eq('match_id', matchId)
        .order('created_at', ascending: true)
        .map((data) => data.map((json) => MessageModel.fromJson(json)).toList());
  }

  Future<void> sendMessage(String matchId, String content) async {
    final currentUserId = _client.auth.currentUser?.id;
    if (currentUserId == null) return;

    await _client.from('messages').insert({
      'match_id': matchId,
      'sender_id': currentUserId,
      'content': content,
    });
  }
}