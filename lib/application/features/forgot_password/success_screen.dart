import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';
import 'package:zyra_momments_app/application/config/widgets/primary_button.dart';
import 'package:zyra_momments_app/application/features/auth/auth_screen.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Stack(
              children: [
                LottieBuilder.asset(
                  'assets/lottie/success.json',
                  repeat: false,
                ),
                Positioned(
                  top: height * 0.4,
                  left: width * 0.17,
                  child: CustomText(
                    text: "Password Changed",
                    fontSize: 36,
                    FontFamily: 'amaranth',
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            SizedBox(
              height: height * 0.02,
            ),
            CustomText(
              text: "Your password has been changed\nscuccess",
              fontSize: 20,
              fontWeight: FontWeight.w500,
              FontFamily: 'roboto',
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: height * 0.02,
            ),
            PrimaryButton(
                label: "Back to Login",
                ontap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => AuthScreen()),
                    (Route<dynamic> route) => false,
                  );
                })
          ],
        ),
      ),
    );
  }
}
