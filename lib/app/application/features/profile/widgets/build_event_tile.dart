  import 'package:flutter/material.dart';
import 'package:zyra_momments_app/app/application/features/profile/sub_screens/purchased_event_screen/purchased_event_screen.dart';
import 'package:zyra_momments_app/app/application/features/profile/widgets/tile_info_card.dart';

Widget buildEventsTile(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const PurchasedEventScreen()),
        );
      },
      child:  TileInfoCard(
        leadingIcon: Icons.swap_horiz_outlined,
        label: "Events",
        trailingIcon: Icons.arrow_forward_ios_rounded,
      ),
    );
  }