 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zyra_momments_app/app/application/features/events/bloc/event_bloc.dart';
import 'package:zyra_momments_app/app/application/features/home/home_widgets/build_categorie_section.dart';
import 'package:zyra_momments_app/app/application/features/home/home_widgets/build_event_grid.dart';
import 'package:zyra_momments_app/app/application/features/home/home_widgets/build_vendor_section.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

Widget buildContentSection(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          buildCategorySection(context),
          SizedBox(height: height * 0.03),
          _buildEventsHeaderSection(),
          SizedBox(height: height * 0.02),
          _buildEventsDescriptionSection(),
          SizedBox(height: height * 0.07),
          _buildEventActionButtons(width, height),
          SizedBox(height: height * 0.05),
          _buildEventsGridSection(),
          buildVendorsSection(width, height),
        ],
      ),
    );
  }



  Widget _buildEventsHeaderSection() {
    return Align(
      alignment: Alignment.centerLeft,
      child: CustomText(
        text: "What's happening next?",
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildEventsDescriptionSection() {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        width: double.infinity,
        child: Expanded(
          child: CustomText(
            text:
                "Discover the hottest upcoming events in your area. From conferences to festivals, we've got you covered with the most exciting gatherings on the horizon.",
            fontSize: 16,
            maxLines: 4,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildEventActionButtons(double width, double height) {
    return Row(
      children: [
        _buildActionButton(
          width: width * 0.38,
          height: height * 0.1,
          text: "View All Events",
          backgroundColor: AppTheme.darkSecondaryColor,
        ),
        SizedBox(width: width * 0.02),
        _buildActionButton(
          width: width * 0.30,
          height: height * 0.1,
          text: "See More",
          backgroundColor: AppTheme.darkSecondaryColor,
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required double width,
    required double height,
    required String text,
    required Color backgroundColor,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(5),
      ),
      alignment: Alignment.center,
      child: CustomText(
        text: text,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildEventsGridSection() {
    return BlocBuilder<EventBloc, EventState>(
      builder: (context, state) {
        if (state is GetAllEventLoadingState) {
          return _buildEventShimmerGrid(context);
        } else if (state is GetAllEVentFailureState) {
          return Center(child: CustomText(text: state.errorMessage));
        } else if (state is GetAllEventSuccessState) {
          return buildEventGrid(state.events , context);
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildEventShimmerGrid(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.width;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 8,
        crossAxisSpacing: 6,
        childAspectRatio: 0.67,
        crossAxisCount: 2,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: AppTheme.darkShimmerBaseColor,
          highlightColor: AppTheme.darkShimmerHeighlightColor,
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.darkSecondaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image placeholder
                Container(
                  width: double.infinity,
                  height: height * 0.15,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: height * 0.01),
                        Container(
                            width: width * 0.4,
                            height: 16,
                            color: Colors.white),
                        SizedBox(height: height * 0.004),
                        Container(
                            width: width * 0.25,
                            height: 13,
                            color: Colors.white),
                        SizedBox(height: height * 0.01),
                        Row(
                          children: [
                            Column(
                              children: [
                                Icon(Icons.calendar_today_outlined,
                                    size: 15, color: Colors.white),
                                Icon(Icons.timer_outlined,
                                    size: 16, color: Colors.white),
                                Icon(Icons.location_on,
                                    size: 15, color: Colors.white),
                              ],
                            ),
                            SizedBox(width: width * 0.02),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width: width * 0.25,
                                    height: 15,
                                    color: Colors.white),
                                SizedBox(height: height * 0.004),
                                Container(
                                    width: width * 0.2,
                                    height: 15,
                                    color: Colors.white),
                                SizedBox(height: height * 0.004),
                                Container(
                                    width: width * 0.35,
                                    height: 15,
                                    color: Colors.white),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.01),
                        Container(
                          width: double.infinity,
                          height: height * 0.04,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

 
