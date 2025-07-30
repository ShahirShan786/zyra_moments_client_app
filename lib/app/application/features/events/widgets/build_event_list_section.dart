 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zyra_momments_app/app/application/features/events/bloc/event_bloc.dart';
import 'package:zyra_momments_app/app/application/features/events/widgets/build_event_grid_container.dart';
import 'package:zyra_momments_app/app/application/features/events/widgets/build_event_shimmer_loading.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

Widget buildEventListSection(double width, double height) {
    return BlocBuilder<EventBloc, EventState>(
      builder: (context, state) {
        if (state is GetAllEventLoadingState) {
          return buildEventShimmerLoading(width, height);
        } else if (state is GetAllEVentFailureState) {
          return Center(child: CustomText(text: state.errorMessage));
        } else if (state is EventNotFound) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: CustomText(text: "No Events available with this name"),
            ),
          );
        } else if (state is GetAllEventSuccessState) {
          return buildEventGridContainer(state.events, width, height);
        }
        return const SizedBox();
      },
    );
  }