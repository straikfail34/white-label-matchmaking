import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../data/models/profile_model.dart';
import '../../../core/constants/dimensions.dart';
import 'glassmorphism_panel.dart';

class SwipeCard extends StatelessWidget {
  final ProfileModel profile;

  const SwipeCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radius),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Capa inferior: Imagen del perfil
          ClipRRect(
            borderRadius: BorderRadius.circular(AppDimensions.radius),
            child: profile.photos.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: profile.photos.first,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => const Center(
                      child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
                    ),
                  )
                : Container(
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(Icons.person, size: 100, color: Colors.grey),
                    ),
                  ),
          ),
          // Capa superior: Datos biométricos y etiquetas (Glassmorphism)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: GlassmorphismPanel(profile: profile),
          ),
        ],
      ),
    );
  }
}