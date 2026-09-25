import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../controllers/match_controller.dart';

class MatchListScreen extends ConsumerWidget {
  const MatchListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matchesState = ref.watch(matchControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Matches'),
        centerTitle: true,
      ),
      body: matchesState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error al cargar matches: $error')),
        data: (matches) {
          if (matches.isEmpty) {
            return const Center(child: Text('Aún no tienes emparejamientos.'));
          }
          return ListView.builder(
            itemCount: matches.length,
            itemBuilder: (context, index) {
              final match = matches[index];
              final profile = match.matchedUser;
              if (profile == null) return const SizedBox.shrink();

              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: profile.photos.isNotEmpty
                      ? CachedNetworkImageProvider(profile.photos.first)
                      : null,
                  child: profile.photos.isEmpty ? const Icon(Icons.person) : null,
                ),
                title: Text(profile.displayName),
                subtitle: const Text('Toca para abrir el chat'),
                onTap: () {
                  context.push('/chat/${match.id}');
                },
              );
            },
          );
        },
      ),
    );
  }
}