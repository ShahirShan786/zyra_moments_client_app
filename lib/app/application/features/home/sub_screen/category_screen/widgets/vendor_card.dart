import 'package:flutter/material.dart';
import 'package:zyra_momments_app/app/application/features/home/sub_screen/vendor_profile_screen/vendor_profile_screen.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';
import 'package:zyra_momments_app/data/models/vendor_category_model.dart';

class VendorCard extends StatelessWidget {
  const VendorCard({
    super.key,
    required this.vendor,
    required this.width,
    required this.height,
  });

  final Vendor vendor;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => VendorProfileScreen(
                  id: vendor.id,
                )));
      },
      child: Container(
        width: width * 0.46,
        height: height * 0.30,
        decoration: BoxDecoration(
            color: AppTheme.darkBoxColor,
            borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // for circle avatar and name
              SizedBox(
                height: height * 0.011,
              ),
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey[800],
                    radius: width * 0.065,
                    child: Center(
                      child: CustomText(text: "VM"),
                    ),
                  ),
                  // for name
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: vendor.firstName,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(
                          height: height * 0.012,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star_border,
                              color: Colors.amber,
                              size: width * 0.055,
                            ),
                            Icon(
                              Icons.star_border,
                              color: Colors.amber,
                              size: width * 0.055,
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Container(
                width: width * 0.6,
                height: height * 0.09,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: AppTheme.darkPrimaryColor,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: AppTheme.darkBorderColor,
                    )),
                child: CustomText(
                  text: "View Details",
                  fontSize: 15,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
