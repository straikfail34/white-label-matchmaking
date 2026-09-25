import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/match_model.dart';
import '../../../data/repositories/chat_repository.dart';

final matchControllerProvider = StateNotifierProvider<MatchController, AsyncValue<List<MatchModel>>>((ref) {
  return MatchController(ref.watch(chatRepositoryProvider));
});

class MatchController extends StateNotifier<AsyncValue<List<MatchModel>>> {
  final ChatRepository _repository;

  MatchController(this._repository) : super(const AsyncLoading()) {
    loadMatches();
  }

  Future<void> loadMatches() async {
    state = const AsyncLoading();
    try {
      final matches = await _repository.getMatches();
      state = AsyncData(matches);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}