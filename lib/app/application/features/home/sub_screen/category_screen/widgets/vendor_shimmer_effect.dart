import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zyra_momments_app/application/config/theme.dart';

class VendorShimmerLoading extends StatelessWidget {
  final double height;
  final double width;

  const VendorShimmerLoading(
      {super.key, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 6, // Show 6 shimmer items
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.33,
        mainAxisSpacing: height * 0.03,
        crossAxisSpacing: width * 0.02,
      ),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: AppTheme.darkShimmerBaseColor,
          highlightColor: AppTheme.darkShimmerHeighlightColor,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 4),
          ),
        );
      },
    );
  }
}
