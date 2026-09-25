import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../data/models/profile_model.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/dimensions.dart';

class GlassmorphismPanel extends StatelessWidget {
  final ProfileModel profile;

  const GlassmorphismPanel({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(AppDimensions.radius),
        bottomRight: Radius.circular(AppDimensions.radius),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(AppDimensions.sm),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4), // Opacidad base para el cristal
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${profile.displayName}${profile.age != null ? ', ${profile.age}' : ''}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppDimensions.xs),
              if (profile.bio != null && profile.bio!.isNotEmpty) ...[
                Text(
                  profile.bio!,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppDimensions.xs),
              ],
              if (profile.tags.isNotEmpty)
                Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: profile.tags.map((tag) => Chip(
                    label: Text(tag, style: const TextStyle(fontSize: 12)),
                    backgroundColor: AppColors.primary.withOpacity(0.8),
                    labelStyle: const TextStyle(color: Colors.white),
                    side: BorderSide.none,
                  )).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}