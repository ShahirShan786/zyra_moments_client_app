  import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zyra_momments_app/app/data/models/event_model.dart';

Widget buildPosterImage(double height , Event event) {
    return SizedBox(
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: event.posterImage!.isNotEmpty
            ? Image.network(
                event.posterImage!,
                fit: BoxFit.cover,
                height: height * 0.30,
                width: double.infinity,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return _buildImageShimmer(height);
                },
                errorBuilder: (_, __, ___) => _buildErrorImage(height),
              )
            : _buildPlaceholderImage(height),
      ),
    );
  }

  Widget _buildImageShimmer(double height) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: height * 0.30,
        width: double.infinity,
        color: Colors.white,
      ),
    );
  }

  Widget _buildErrorImage(double height) {
    return Container(
      height: height * 0.15,
      width: double.infinity,
      color: Colors.grey[300],
      child: const Icon(Icons.error),
    );
  }

  Widget _buildPlaceholderImage(double height) {
    return Container(
      height: height * 0.15,
      width: double.infinity,
      color: Colors.grey[300],
      child: const Icon(Icons.image_not_supported),
    );
  }