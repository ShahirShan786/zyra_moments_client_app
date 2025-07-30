import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zyra_momments_app/application/config/theme.dart';

Widget buildShimmerCard(double width, double height) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Shimmer.fromColors(
      baseColor: AppTheme.darkShimmerBaseColor,
      highlightColor: AppTheme.darkShimmerHeighlightColor,
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(minHeight: height * 0.24),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppTheme.darkSecondaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 20, width: width * 0.6, color: Colors.white),
            const SizedBox(height: 10),
            Container(height: 14, width: width * 0.8, color: Colors.white),
            const SizedBox(height: 10),
            Container(height: 14, width: width * 0.4, color: Colors.white),
            const SizedBox(height: 10),
            Container(height: 14, width: width * 0.5, color: Colors.white),
            const SizedBox(height: 10),
            Container(height: 14, width: width * 0.3, color: Colors.white),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(height: 20, width: width * 0.2, color: Colors.white),
                Container(
                  height: height * 0.045,
                  width: width * 0.25,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}
