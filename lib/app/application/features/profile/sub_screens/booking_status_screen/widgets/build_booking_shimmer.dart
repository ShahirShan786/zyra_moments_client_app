  import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zyra_momments_app/application/config/theme.dart';

Widget buildBookingShimmer(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;
    
    return Shimmer.fromColors(
      baseColor: AppTheme.darkShimmerBaseColor,
      highlightColor: AppTheme.darkShimmerHeighlightColor,
      child: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            5,
                            (index) => Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Container(
                                width: 80,
                                height: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: width * 0.02),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 120,
                              height: 16,
                              color: Colors.white,
                              margin: const EdgeInsets.only(bottom: 8.0),
                            ),
                            Container(
                              width: 100,
                              height: 16,
                              color: Colors.white,
                              margin: const EdgeInsets.only(bottom: 8.0),
                            ),
                            Container(
                              width: 80,
                              height: 16,
                              color: Colors.white,
                              margin: const EdgeInsets.only(bottom: 8.0),
                            ),
                            Container(
                              width: 60,
                              height: 16,
                              color: Colors.white,
                              margin: const EdgeInsets.only(bottom: 8.0),
                            ),
                            Container(
                              width: width * 0.25,
                              height: width * 0.06,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: width * 0.38,
                          height: width * 0.095,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }