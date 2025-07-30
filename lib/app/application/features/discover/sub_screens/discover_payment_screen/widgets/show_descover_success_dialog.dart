import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:zyra_momments_app/app/application/features/discover/sub_screens/discover_payment_screen/widgets/featured_box.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';
import 'package:zyra_momments_app/application/features/dashboard/dashboard_screen.dart';
import 'package:zyra_momments_app/application/features/dashboard/navigation/bloc/navigation_bloc.dart';
import 'package:zyra_momments_app/application/features/dashboard/navigation/bloc/navigation_tab.dart';

void showDiscoverSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: AppTheme.darkBoxColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          width: 350,
          height: 500,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 80,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: LottieBuilder.asset(
                        "assets/lottie/success.json",
                        height: 320,
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
              const SizedBox(height: 10),
              Container(
                width: 150,
                height: 35,
                decoration: BoxDecoration(
                  color: AppTheme.darkSecondaryColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                alignment: Alignment.center,
                child: CustomText(
                  text: "Master of Ceremonie",
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.darkTextColorSecondary,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                child: CustomText(
                  textAlign: TextAlign.center,
                  maxLines: 4,
                  text: "Dear User, We're thrilled to announce your promotion! You now have the ability to host and manage events on our platform.",
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.darkTextColorSecondary,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 160,
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
                    ),
                    FeatureBox(
                      label: "Manage Attendees",
                      body: "Invite and organize\nParticipants",
                    ),
                    FeatureBox(
                      label: "Custom themes",
                      body: "Personalized events\nappearence",
                    ),
                    FeatureBox(
                      label: "Analytics",
                      body: "Track event \nPerfomence",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => DashBoardScreen()),
                    (route) => false,
                  );
                  context.read<NavigationBloc>().add(
                    NavigationTabChanged(NavigationTab.profile),
                  );
                },
                child: Container(
                  width: 130,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppTheme.darkTextColorSecondary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: CustomText(
                    text: "Get Started",
                    fontSize: 18,
                    color: AppTheme.darkBlackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
