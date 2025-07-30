import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:zyra_momments_app/app/application/features/home/blocs/bloc/home_bloc.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

class ProfileScreenss extends StatelessWidget {
  const ProfileScreenss({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    Future.microtask(() {
      BlocProvider.of<HomeBloc>(context).add(GetCategoryRequestEvent());
    });

    return Scaffold(
      body: Center(
        child: TextButton(
            onPressed: () {
              showDiscoverSuccessDialog(context, width, height);
            },
            child: CustomText(text: "Alert")),
      ),
    );
  }

  void showDiscoverSuccessDialog(
      BuildContext context, double width, double height) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: AppTheme.darkBoxColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            width: double.infinity,
            height: 500,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                SizedBox(
                  // color: Colors.blueGrey,
                  width: double.infinity,
                  height: height * 0.1,
                  // color: Colors.blueAccent,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: LottieBuilder.asset(
                          "assets/lottie/success.json",
                          height: height * 0.4,
                        ),
                      ),
                    ],
                  ),
                ),
                CustomText(
                  text: "Congratulations!",
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                CustomText(
                  text: "You've been promoted to!",
                  fontSize: 15,
                  color: AppTheme.darkTextColorSecondary,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: height * 0.012,
                ),
                Container(
                  width: width * 0.43,
                  height: height * 0.042,
                  decoration: BoxDecoration(
                      color: AppTheme.darkSecondaryColor,
                      borderRadius: BorderRadius.circular(5)),
                  alignment: Alignment.center,
                  child: CustomText(
                    text: "Master of Ceremonies",
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.darkTextColorSecondary,
                  ),
                ),
                SizedBox(
                  height: height * 0.012,
                ),
                SizedBox(
                  child: CustomText(
                    textAlign: TextAlign.center,
                    maxLines: 4,
                    text:
                        "Dear User, We're thrilled to announce your promotion! You now have the ability to host and manage events on our platform.",
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.darkTextColorSecondary,
                  ),
                ),
                SizedBox(
                  height: height * 0.012,
                ),
                SizedBox(
                  width: double.infinity,
                  height: height * 0.20,
                  // color: Colors.green,
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1.90,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      FeatureBox(
                        label: "Create Events",
                        body: "Design and schedule new\nevents",
                        width: width,
                        height: height,
                      ),
                      FeatureBox(
                        label: "Manage Attendees",
                        body: "Invite and organize\nParticipants",
                        width: width,
                        height: height,
                      ),
                      FeatureBox(
                        label: "Custom themes",
                        body: "Personalized events\nappearence",
                        width: width,
                        height: height,
                      ),
                      FeatureBox(
                        label: "Analytics",
                        body: "Track event \nPerfomence",
                        width: width,
                        height: height,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.012,
                ),
                Container(
                  width: width * 0.38,
                  height: height * 0.047,
                  decoration: BoxDecoration(
                      color: AppTheme.darkTextColorSecondary,
                      borderRadius: BorderRadius.circular(8)),
                  alignment: Alignment.center,
                  child: CustomText(
                    text: "Get Started",
                    fontSize: 18,
                    color: AppTheme.darkBlackColor,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}


class FeatureBox extends StatelessWidget {
  final String label;
  final String body;
  final double width;
  final double height;

  const FeatureBox(
      {super.key,
      required this.label,
      required this.body,
      required this.width,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.38,
      height: height * 0.075,
      decoration: BoxDecoration(
          color: AppTheme.darkSecondaryColor,
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        spacing: height * 0.005,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            text: label,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
          CustomText(
              textAlign: TextAlign.center,
              fontSize: 12,
              color: AppTheme.darkTextLightColor,
              fontWeight: FontWeight.w400,
              text: body)
        ],
      ),
    );
  }
}