 import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zyra_momments_app/application/config/theme.dart';

Widget buildEventShimmerLoading(double width, double height) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 8,
        crossAxisSpacing: 6,
        childAspectRatio: 0.67,
        crossAxisCount: 2,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: AppTheme.darkShimmerBaseColor,
          highlightColor: AppTheme.darkShimmerHeighlightColor,
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.darkSecondaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: height * 0.15,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: height * 0.01),
                      Container(width: width * 0.4, height: 16, color: Colors.white),
                      SizedBox(height: height * 0.004),
                      Container(width: width * 0.25, height: 13, color: Colors.white),
                      SizedBox(height: height * 0.01),
                      Row(
                        children: [
                          Column(
                            children: [
                              Icon(Icons.calendar_today_outlined, size: 15, color: Colors.white),
                              Icon(Icons.timer_outlined, size: 16, color: Colors.white),
                              Icon(Icons.location_on, size: 15, color: Colors.white),
                            ],
                          ),
                          SizedBox(width: width * 0.02),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(width: width * 0.25, height: 15, color: Colors.white),
                              SizedBox(height: height * 0.004),
                              Container(width: width * 0.2, height: 15, color: Colors.white),
                              SizedBox(height: height * 0.004),
                              Container(width: width * 0.35, height: 15, color: Colors.white),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.01),
                      Container(
                        width: double.infinity,
                        height: height * 0.04,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }