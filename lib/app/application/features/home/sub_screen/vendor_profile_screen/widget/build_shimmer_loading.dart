  import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zyra_momments_app/application/config/theme.dart';

Widget buildShimmerLoading(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.width;
    
    return Shimmer.fromColors(
      baseColor: Colors.grey[800]!,
      highlightColor: Colors.grey[700]!,
      child: Column(
        children: [
          // Profile card shimmer
          _buildShimmerProfileCard(width, height),
          // Tab bar shimmer
          _buildShimmerTabContent(width, height),
        ],
      ),
    );
  }

  Widget _buildShimmerProfileCard(double width, double height) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        height: height * 0.40,
        decoration: BoxDecoration(
          color: AppTheme.darkSecondaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: height * 0.20,
                  height: height * 0.20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[800],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: height * 0.02),
                      Container(width: width * 0.5, height: 24, color: Colors.grey[800]),
                      SizedBox(height: height * 0.01),
                      Container(width: width * 0.4, height: 18, color: Colors.grey[800]),
                      SizedBox(height: height * 0.01),
                      Container(width: 24, height: 24, color: Colors.grey[800]),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.01),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: width * 0.22,
                height: height * 0.08,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[800],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerTabContent(double width, double height) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: height * 0.13,
            decoration: BoxDecoration(
              color: AppTheme.darkSecondaryColor,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          SizedBox(height: height * 0.02),
          Container(
            width: double.infinity,
            height: 475,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: AppTheme.darkBorderColor),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: width * 0.7, height: 20, color: Colors.grey[800]),
                  SizedBox(height: 20),
                  Container(width: width * 0.5, height: 16, color: Colors.grey[800]),
                  SizedBox(height: 30),
                  Container(width: width * 0.7, height: 20, color: Colors.grey[800]),
                  SizedBox(height: 20),
                  Container(width: width * 0.5, height: 16, color: Colors.grey[800]),
                  SizedBox(height: 30),
                  Container(width: width * 0.7, height: 20, color: Colors.grey[800]),
                  SizedBox(height: 20),
                  Container(width: width * 0.5, height: 16, color: Colors.grey[800]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }