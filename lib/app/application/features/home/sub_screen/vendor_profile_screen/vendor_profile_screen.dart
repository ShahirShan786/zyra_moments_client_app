import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zyra_momments_app/app/application/features/home/blocs/bloc/home_bloc.dart';
import 'package:zyra_momments_app/app/application/features/home/sub_screen/vendor_profile_screen/widget/build_profile_card.dart';
import 'package:zyra_momments_app/app/application/features/home/sub_screen/vendor_profile_screen/widget/build_shimmer_loading.dart';
import 'package:zyra_momments_app/app/application/features/home/sub_screen/vendor_profile_screen/widget/build_tab_section.dart';
import 'package:zyra_momments_app/app/data/models/vendor_profile_model.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

class VendorProfileScreen extends StatelessWidget {
  final String id;
  const VendorProfileScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    Future.microtask(() {
      BlocProvider.of<HomeBloc>(context)
          .add(GetVendorProfileDetailsRequestEvent(categoryId: id));
    });
    
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: CustomText(
            text: "Vendor Details",
            fontSize: 25,
            FontFamily: 'shafarik',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is CategoryLoadingState) {
                return buildShimmerLoading(context);
              } else if (state is GetVendorProfileFaiureState) {
                return Center(child: CustomText(text: state.errorMessage));
              } else if (state is GetvendorProfileSuccessState) {
                return _buildProfileContent(context, state.vendorDetails);
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}


  Widget _buildProfileContent(BuildContext context, VendorProfileModel vendorDetails) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.width;
    
    if (vendorDetails.vendorData == null) {
      return Center(child: Text('Vendor data not available'));
    }
    
    final vendor = vendorDetails.vendorData!;
    final vendorWorkSamples = vendor.workSamples;
    final vendorServices = vendor.services;

    log('Vendor services count: ${vendorDetails.vendorData?.services.length}');
    log('First service title: ${vendorDetails.vendorData?.services.firstOrNull?.serviceTitle}');
    
    return Column(
      children: [
        buildProfileCard(context, vendor, vendorServices, width, height),
        buildTabSection(context, vendor, vendorWorkSamples, vendorServices, width, height),
      ],
    );
  }



































