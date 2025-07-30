import 'package:flutter/material.dart';
import 'package:zyra_momments_app/app/application/features/profile/sub_screens/booking_status_screen/booking_status_screen.dart';
import 'package:zyra_momments_app/app/application/features/profile/widgets/tile_info_card.dart';

Widget buildBookingTile(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const BookingStatusScreen()),
      ),
      child:  TileInfoCard(
        leadingIcon: Icons.description_outlined,
        label: "Booking",
        trailingIcon: Icons.arrow_forward_ios_rounded,
      ),
    );
  }