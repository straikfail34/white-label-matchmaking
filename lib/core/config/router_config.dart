import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../data/repositories/auth_repository.dart';
import '../../features/auth/screens/sign_in_screen.dart';
import '../../features/discovery/screens/home_screen.dart';
import '../../features/matches/screens/match_list_screen.dart';
import '../../features/chat/screens/chat_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);
  
  return GoRouter(
    initialLocation: '/sign-in',
    redirect: (context, state) {
      final isAuthenticated = authState.value?.session != null;
      final isGoingToSignIn = state.matchedLocation == '/sign-in';

      if (!isAuthenticated && !isGoingToSignIn) {
        return '/sign-in';
      }
      if (isAuthenticated && isGoingToSignIn) {
        return '/';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/sign-in',
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/matches',
        builder: (context, state) => const MatchListScreen(),
      ),
      GoRoute(
        path: '/chat/:id',
        builder: (context, state) {
          final matchId = state.pathParameters['id']!;
          return ChatScreen(matchId: matchId);
        },
      ),
    ],
  );
});