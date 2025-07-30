import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zyra_momments_app/application/config/theme.dart';

class ProfileShimmer extends StatelessWidget {
  final double height;
  final double width;

  const ProfileShimmer({required this.height, required this.width, super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppTheme.darkShimmerBaseColor,
      highlightColor: AppTheme.darkShimmerHeighlightColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileHeaderShimmer(),
          SizedBox(height: height * 0.01),
          _buildUserDetailsShimmer(),
          SizedBox(height: 12),
          _buildEmailShimmer(),
          SizedBox(height: height * 0.01),
          _buildAdditionalInfoShimmer(),
        ],
      ),
    );
  }

  Widget _buildProfileHeaderShimmer() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.01),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: width * 0.04),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(width: width * 0.4, height: 25, color: Colors.white),
              const SizedBox(height: 5),
              Container(width: width * 0.3, height: 15, color: Colors.white),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUserDetailsShimmer() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildShimmerBox(width * 0.2, 15),
            const SizedBox(height: 12),
            _buildShimmerBox(width * 0.2, 15),
          ],
        ),
        SizedBox(width: width * 0.02),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildShimmerBox(width * 0.3, 15),
            const SizedBox(height: 12),
            _buildShimmerBox(width * 0.3, 15),
          ],
        ),
        const Spacer(),
        _buildShimmerBox(width * 0.2, 15),
      ],
    );
  }

  Widget _buildEmailShimmer() {
    return Row(
      children: [
        _buildShimmerBox(width * 0.2, 15),
        SizedBox(width: width * 0.04),
        _buildShimmerBox(width * 0.4, 15),
      ],
    );
  }

  Widget _buildAdditionalInfoShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildShimmerBox(width * 0.4, 15),
        SizedBox(height: height * 0.008),
        _buildShimmerBox(width * 0.7, 15),
      ],
    );
  }

  Widget _buildShimmerBox(double width, double height) {
    return Container(
      width: width,
      height: height,
      color: Colors.white,
    );
  }
}