
  import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zyra_momments_app/app/application/features/events/event_booking_screen/bloc/event_card_bloc.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

void showEventFailureDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.darkSecondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildErrorIcon(),
              SizedBox(height: 16),
              _buildErrorTitle(),
              SizedBox(height: 8),
              _buildErrorMessage(errorMessage),
              SizedBox(height: 20),
              _buildErrorActionButtons(context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildErrorIcon() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.error_outline,
        color: Colors.red,
        size: 50,
      ),
    );
  }

  Widget _buildErrorTitle() {
    return CustomText(
      text: "Payment Failed",
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.red,
    );
  }

  Widget _buildErrorMessage(String errorMessage) {
    return CustomText(
      text: errorMessage,
      fontSize: 14,
      color: AppTheme.darkTextLightColor,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildErrorActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildCancelButton(context),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _buildRetryButton(context),
        ),
      ],
    );
  }

  Widget _buildCancelButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.of(context).pop(),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: CustomText(
        text: "Cancel",
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }

  Widget _buildRetryButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pop();
        context.read<EventCardBloc>().add(
              EventConfirmPaymentEventReqeust(amount: "49"),
            );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.paymentButtonColor,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: CustomText(
        text: "Retry",
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }

