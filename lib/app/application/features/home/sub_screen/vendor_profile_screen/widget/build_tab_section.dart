  import 'package:flutter/material.dart';
import 'package:zyra_momments_app/app/application/features/home/sub_screen/vendor_profile_screen/widget/build_personal_details.dart';
import 'package:zyra_momments_app/app/application/features/home/sub_screen/vendor_profile_screen/widget/service_section.dart';
import 'package:zyra_momments_app/app/application/features/home/sub_screen/vendor_profile_screen/widget/work_sample_section.dart';
import 'package:zyra_momments_app/app/data/models/vendor_profile_model.dart';


import 'package:zyra_momments_app/application/config/theme.dart';

Widget buildTabSection(
    BuildContext context,
    VendorData vendor,
    List<WorkSample> workSamples,
    List<Service> services,
    double width,
    double height
  ) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: height * 0.13,
            padding: EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: AppTheme.darkSecondaryColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: TabBar(
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppTheme.darkPrimaryColor,
              ),
              labelColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: EdgeInsets.symmetric(vertical: 6),
              unselectedLabelColor: Colors.white60,
              dividerHeight: 0,
              tabs: const [
                Tab(text: 'Personal Details'),
                Tab(text: 'Work Samples'),
                Tab(text: 'Services'),
              ],
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
            child: TabBarView(
              children: [
                PersonalDetails(
                  height: height,
                  width: width,
                  phoneNumber: vendor.phoneNumber,
                  email: vendor.email,
                ),
                WorkSampleSection(workSamples: workSamples),
                ServicesSection(
                  services: services,
                  height: height,
                  width: width,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
