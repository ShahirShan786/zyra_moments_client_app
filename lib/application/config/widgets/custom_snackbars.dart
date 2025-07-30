import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

void showSuccessSnackbar(
    {required BuildContext context,
    required double height,
    required String title,
    required String body}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      elevation: 3,
      backgroundColor: Colors.transparent,
      content: Container(
        padding: EdgeInsets.all(8),
        height: 77,
        decoration: BoxDecoration(
            color: AppTheme.darkSecondaryColor,
            border: Border.all(color: const Color.fromARGB(234, 139, 195, 74)),
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            LottieBuilder.asset(
              "assets/lottie/success.json",
              height: height * 0.20,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                CustomText(
                  text: body,
                  fontSize: 15,
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ],
            ))
          ],
        ),
      )));
}

void showFailureScackbar(
    {required BuildContext context,
    required double height,
    required String title,
    required String body}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      elevation: 3,
      backgroundColor: Colors.transparent,
      content: Container(
        padding: EdgeInsets.all(8),
        height: 76,
        decoration: BoxDecoration(
            color:  AppTheme.darkSecondaryColor,
            border: Border.all(color: const Color.fromARGB(223, 224, 27, 9)),
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            LottieBuilder.asset(
              "assets/lottie/fail.json",
              height: height * 0.18,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                CustomText(
                  text: body,
                  fontSize: 15,
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ))
          ],
        ),
      )));
}

void showPrimarySnackBar(BuildContext context, double height) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      elevation: 3,
      backgroundColor: Colors.transparent,
      content: Container(
        padding: EdgeInsets.all(6),
        height: height * 0.11,
        decoration: BoxDecoration(
            color: Color(0xFF001731),
            border: Border.all(color: const Color.fromARGB(223, 23, 77, 213)),
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            LottieBuilder.asset(
              "assets/lottie/success.json",
              height: height * 0.10,
            ),
            // SizedBox(
            //   width: 2,
            // ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "OTP Sent Successfully",
                  fontSize: 18,
                  color: Color(0xFF5FA0EC),
                  fontWeight: FontWeight.bold,
                ),
                CustomText(
                  text:
                      "A 6-digit verification code has been sent to your email. Please check your inbox and enter the code to proceed.",
                  fontSize: 15,
                  color: Color(0xFF2B7CD9),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ],
            ))
          ],
        ),
      )));
}
