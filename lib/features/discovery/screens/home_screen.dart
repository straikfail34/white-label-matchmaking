import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:swipable_stack/swipable_stack.dart';
import '../controllers/discovery_controller.dart';
import '../widgets/swipe_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late final SwipableStackController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SwipableStackController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profilesState = ref.watch(discoveryControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Descubrimiento'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(discoveryControllerProvider.notifier).loadProfiles(),
          ),
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline),
            onPressed: () => context.push('/matches'),
          ),
        ],
      ),
      body: profilesState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Fallo de conexión: $error')),
        data: (profiles) {
          if (profiles.isEmpty) {
            return const Center(child: Text('No hay perfiles disponibles en el área.'));
          }

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SwipableStack(
                controller: _controller,
                itemCount: profiles.length,
                onSwipeCompleted: (index, direction) {
                  final profile = profiles[index];
                  final action = direction == SwipeDirection.right ? 'like' : 'pass';
                  ref.read(discoveryControllerProvider.notifier).swipe(profile.id, action);
                },
                builder: (context, properties) {
                  return SwipeCard(profile: profiles[properties.index]);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}