import 'package:flutter/material.dart';
import 'package:zyra_momments_app/app/application/features/home/sub_screen/category_screen/widgets/vendor_card.dart';
import 'package:zyra_momments_app/data/models/vendor_category_model.dart';

class VendorGrid extends StatelessWidget {
  const VendorGrid({
    super.key,
    required this.height,
    required this.width,
    required this.vendorList,
  });

  final double height;
  final double width;
  final List<Vendor> vendorList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.33,
          mainAxisSpacing: height * 0.03,
          crossAxisSpacing: width * 0.02),
      itemCount: vendorList.length,
      itemBuilder: (context, index) {
        final vendor = vendorList[index];
        // // *****************
        // final vendors = vendor[index];
        return VendorCard(vendor: vendor, width: width, height: height);
      },
    );
  }
}

