import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/profile_model.dart';
import '../../../data/repositories/discovery_repository.dart';

final discoveryControllerProvider = StateNotifierProvider<DiscoveryController, AsyncValue<List<ProfileModel>>>((ref) {
  return DiscoveryController(ref.watch(discoveryRepositoryProvider));
});

class DiscoveryController extends StateNotifier<AsyncValue<List<ProfileModel>>> {
  final DiscoveryRepository _repository;

  DiscoveryController(this._repository) : super(const AsyncLoading()) {
    loadProfiles();
  }

  Future<void> loadProfiles() async {
    state = const AsyncLoading();
    try {
      final profiles = await _repository.getProfilesToSwipe();
      state = AsyncData(profiles);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> swipe(String toUserId, String action) async {
    try {
      await _repository.registerSwipe(toUserId: toUserId, action: action);
    } catch (e) {
      // El manejo de errores de red silenciado requiere telemetría en producción
    }
  }
}