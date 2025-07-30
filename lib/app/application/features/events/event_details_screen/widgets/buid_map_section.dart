 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zyra_momments_app/app/application/features/events/event_details_screen/bloc/evet_details_bloc.dart';

Widget buildMapSection(double height) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: BlocBuilder<EvetDetailsBloc, EvetDetailsState>(
        builder: (context, state) {
          if (state is EvetDetailsLoading) {
            return _buildMapShimmer(height);
          } else if (state is EvetDetailsLoaded) {
            return _buildGoogleMap(state, height);
          } else if (state is EvetDetailsError) {
            return Center(child: Text(state.message));
          }
          return _buildMapLoadingPlaceholder();
        },
      ),
    );
  }

  Widget _buildMapShimmer(double height) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: height * 0.25,
        width: double.infinity,
        color: Colors.white,
      ),
    );
  }

  Widget _buildGoogleMap(EvetDetailsLoaded state, double height) {
    return SizedBox(
      height: height * 0.25,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: state.targetPosition,
            zoom: 14,
          ),
          markers: state.markers,
        ),
      ),
    );
  }

  Widget _buildMapLoadingPlaceholder() {
    return const SizedBox(
      height: 150,
      child: Center(child: Text("Map loading...")),
    );
  }