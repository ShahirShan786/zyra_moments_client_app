import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zyra_momments_app/app/application/features/events/event_booking_screen/bloc/event_card_bloc.dart';
import 'package:zyra_momments_app/app/application/features/events/event_booking_screen/widgets/build_event_failure_dialogue.dart';
import 'package:zyra_momments_app/app/application/features/events/event_booking_screen/widgets/show_event_success_dialoague.dart';
import 'package:zyra_momments_app/app/data/models/event_model.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

Widget buildPaymentSection(double width, double height , Event events) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Complete Your Payment",
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        BlocListener<EventCardBloc, EventCardState>(
          listener: (context, state) {
            if (state is EventCardPaymentSuccessState) {
              showEventSuccessDialog(context , events);
            } else if (state is EventCardPaymentFailureState) {
              showEventFailureDialog(context, state.errorMessage!);
            }
          },
          child: BlocBuilder<EventCardBloc, EventCardState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: GestureDetector(
                  onTap: state.isSubmitting
                      ? null
                      : () {
                          context.read<EventCardBloc>().add(
                                EventConfirmPaymentEventReqeust(amount: "49"),
                              );
                        },
                  child: Container(
                    width: double.infinity,
                    height: height * 0.065,
                    decoration: BoxDecoration(
                      color: state.isSubmitting
                          ? Colors.grey
                          : AppTheme.paymentButtonColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    alignment: Alignment.center,
                    child: state.isSubmitting
                        ? _buildLoadingIndicator()
                        : CustomText(
                            text: "Continue Payment - ₹${events.pricePerTicket}",
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
        SizedBox(width: 10),
        CustomText(
          text: "Processing...",
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }