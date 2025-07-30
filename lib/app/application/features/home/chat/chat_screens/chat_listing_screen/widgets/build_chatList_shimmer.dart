import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zyra_momments_app/application/config/theme.dart';

Widget buildChatListShimmer(BuildContext context) {
  final width = MediaQuery.of(context).size.width;

  return Shimmer.fromColors(
    baseColor: AppTheme.darkShimmerBaseColor,
    highlightColor: AppTheme.darkShimmerHeighlightColor,
    child: ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
          color: AppTheme.darkSecondaryColor,
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            leading: CircleAvatar(
              radius: width * 0.075,
              backgroundColor: Colors.grey[800],
            ),
            title: Container(
              width: width * 0.5,
              height: 16,
              color: Colors.grey[800],
            ),
            subtitle: Container(
              width: width * 0.7,
              height: 14,
              color: Colors.grey[800],
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 12,
                  color: Colors.grey[800],
                ),
                const SizedBox(height: 8),
                CircleAvatar(
                  radius: width * 0.035,
                  backgroundColor: Colors.grey[800],
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
