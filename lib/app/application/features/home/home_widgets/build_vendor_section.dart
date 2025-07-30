

  import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zyra_momments_app/app/application/features/home/blocs/best_vendor_bloc/bloc/best_vendor_bloc.dart';
import 'package:zyra_momments_app/app/application/features/home/sub_screen/vendor_profile_screen/vendor_profile_screen.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';
import 'package:zyra_momments_app/data/models/vendor_category_model.dart';

Widget buildVendorsSection(double width, double height ) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: CustomText(
            text: "Our Best Vendors",
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: height * 0.02),
        Container(
          width: double.infinity,
          height: 300,
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: BlocBuilder<BestVendorBloc, BestVendorState>(
            builder: (context, state) {
              if (state is GetBestvendorLoadingState) {
                return _buildVendorShimmer(width, height);
              } else if (state is GetBestvendorFailureState) {
                return Center(child: CustomText(text: state.errorMessage));
              } else if (state is GetBestVenodorSuccessState) {
                return _buildVendorGrid(state.bestVendors, width, height);
              }
              return SizedBox();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildVendorGrid(List<Vendor> vendors, double width, double height) {
    return GridView.builder(
      physics: BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.33,
        mainAxisSpacing: height * 0.03,
        crossAxisSpacing: width * 0.02,
      ),
      itemCount: 3,
      itemBuilder: (context, index) {
        return _buildVendorCard(vendors[index], width, height , context);
      },
    );
  }

  Widget _buildVendorCard(Vendor vendor, double width, double height , BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => VendorProfileScreen(id: vendor.id),
          ),
        );
      },
      child: Container(
        width: width * 0.46,
        height: height * 0.30,
        decoration: BoxDecoration(
          color: AppTheme.darkBoxColor,
          border: Border.all(color: AppTheme.darkBorderColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: height * 0.011),
              _buildVendorInfoRow(vendor, width , context),
              SizedBox(height: height * 0.03),
              _buildVendorDetailsButton(width, height),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVendorInfoRow(Vendor vendor, double width , BuildContext context){
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey[800],
          radius: width * 0.065,
          child: Center(
            child: CustomText(text: "VM"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: vendor.firstName,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.012),
              Row(
                children: [
                  Icon(Icons.star_border,
                      color: Colors.amber, size: width * 0.055),
                  Icon(Icons.star_border,
                      color: Colors.amber, size: width * 0.055),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVendorDetailsButton(double width, double height) {
    return Container(
      width: width * 0.6,
      height: height * 0.09,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppTheme.darkPrimaryColor,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: AppTheme.darkBorderColor),
      ),
      child: CustomText(
        text: "View Details",
        fontSize: 15,
      ),
    );
  }



  Widget _buildVendorShimmer(double width, double height) {
    return Shimmer.fromColors(
      baseColor: AppTheme.darkShimmerBaseColor,
      highlightColor: AppTheme.darkShimmerHeighlightColor,
      child: GridView.builder(
        physics: BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.33,
          mainAxisSpacing: height * 0.03,
          crossAxisSpacing: width * 0.02,
        ),
        itemCount: 4,
        itemBuilder: (context, index) {
          return Container(
            width: width * 0.46,
            height: height * 0.30,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(height: height * 0.011),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: width * 0.065,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                width: 80, height: 20, color: Colors.white),
                            SizedBox(height: height * 0.012),
                            Row(
                              children: [
                                Container(
                                    width: 20, height: 20, color: Colors.white),
                                SizedBox(width: 5),
                                Container(
                                    width: 20, height: 20, color: Colors.white),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.03),
                  Container(
                    width: width * 0.6,
                    height: height * 0.09,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
