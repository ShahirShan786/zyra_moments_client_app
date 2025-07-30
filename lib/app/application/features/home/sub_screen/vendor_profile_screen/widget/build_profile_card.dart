  import 'package:flutter/material.dart';
import 'package:zyra_momments_app/app/application/features/home/sub_screen/service_booking_screen/service_booking_screen.dart';
import 'package:zyra_momments_app/app/data/models/vendor_profile_model.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

Widget buildProfileCard(
    BuildContext context, 
    VendorData vendor, 
    List<Service> services,
    double width, 
    double height
  ) {
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
                CircleAvatar(
                  radius: height * 0.10,
                  backgroundColor: Colors.grey[800],
                  child: Center(
                    child: CustomText(
                      text: "${vendor.firstName.isNotEmpty ? vendor.firstName[0].toUpperCase() : ''}"
                          "${vendor.lastName.isNotEmpty ? vendor.lastName[0].toUpperCase() : ''}",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: height * 0.02),
                      CustomText(
                        text: "${vendor.firstName} ${vendor.lastName}",
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: height * 0.01),
                      CustomText(
                        text: vendor.email,
                        fontSize: 16,
                        color: AppTheme.darkIconColor,
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(height: height * 0.01),
                      const Icon(
                        Icons.star_border,
                        color: Colors.amber,
                        size: 24,
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.01),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ServiceBookingScreen(services: services),
                )),
                child: Container(
                  width: width * 0.22,
                  height: height * 0.08,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppTheme.darkTextColorSecondary,
                  ),
                  child: CustomText(
                    text: "Book",
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.darkPrimaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }