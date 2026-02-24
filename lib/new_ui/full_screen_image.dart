import 'dart:ui';
import 'package:flutter/material.dart';

class FullScreenImageView extends StatelessWidget {
  final String imageUrl;
  final String heroTag;

  const FullScreenImageView({
    super.key,
    required this.imageUrl,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          /// 🔹 Blurred background
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(
                color: Colors.black.withOpacity(0.35),
              ),
            ),
          ),

          /// 🔹 Image
          Center(
            child: Hero(
              tag: heroTag,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: InteractiveViewer(
                  minScale: 0.8,
                  maxScale: 4,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),

          /// 🔹 Close button
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            right: 16,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const CircleAvatar(
                backgroundColor: Colors.black54,
                radius: 18,
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
