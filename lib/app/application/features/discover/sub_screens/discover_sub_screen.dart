import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zyra_momments_app/app/application/core/contents/contents.dart';
import 'package:zyra_momments_app/app/application/features/discover/bloc/discover_bloc.dart';
import 'package:zyra_momments_app/app/application/features/discover/sub_screens/benefic_card.dart';
import 'package:zyra_momments_app/app/application/features/discover/sub_screens/discover_payment_screen/discover_payment_screen.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';
import 'package:zyra_momments_app/application/config/widgets/primary_button.dart';
import 'package:zyra_momments_app/application/core/user_info.dart';

class DiscoverSubScreen extends StatelessWidget {
  const DiscoverSubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DiscoverBloc()..add(StartAnimationEvent()),
      child: DiscoverSubScreenContent(),
    );
  }
}

class DiscoverSubScreenContent extends StatelessWidget {
  const DiscoverSubScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(body: BlocBuilder<DiscoverBloc, DiscoverState>(
        builder: (context, state) {
          bool animate = false;
          if (state is DiscoverAnimating) {
            animate = state.animate;
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: height * 0.3,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/discover_7.jpg"),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height * 0.02,
                      ),
                      CustomText(
                        text: "Become a Master of\nCeremonies",
                        fontSize: 37,
                        fontWeight: FontWeight.bold,
                        FontFamily: "amaranth",
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      CustomText(
                        text:
                            "To host events on our platform, you need to be promoted to the exclusive role of Master of Ceremonies (MC).",
                        fontSize: 18,
                        // color: AppTheme.darkTextColorPrymary,
                        fontWeight: FontWeight.w500,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Benefits",
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      BenefitCard(
                        width: width,
                        animate: animate,
                        content:
                            "Unlock the ability to create and manage your own events",
                      ),
                      BenefitCard(
                          width: width,
                          animate: animate,
                          content:
                              "Reach a wide audience and showcase your talents or services"),
                      BenefitCard(
                          width: width,
                          animate: animate,
                          content:
                              "Get access to premium analytics and promotion tools"),
                      BenefitCard(
                          width: width,
                          animate: animate,
                          content:
                              "Join our exclusive community of event creators"),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      CustomText(
                        text: "How To Get Start",
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      CustomText(
                        maxLines: 5,
                        text: startContent,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.020,
                ),
                AnimatedOpacity(
                    opacity: animate ? 1 : 0,
                    duration: const Duration(milliseconds: 1000),
                    child: PrimaryButton(
                        label: "Continue to payment",
                        ontap: () async {
                          final user = await SecureStorageHelper.loadUser();
                          final userFirstName = user['first_name'];
                          final userLastName = user['last_name'];
                          final userEmail = user['email'];
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DiscoverPaymentScreen(
                              firstName: userFirstName!,
                              lastName: userLastName!,
                              email: userEmail!,
                            ),
                          ));
                        })),
                AnimatedOpacity(
                  opacity: animate ? 1 : 0,
                  duration: const Duration(milliseconds: 1000),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: double.infinity,
                        height: height * 0.055,
                        decoration: BoxDecoration(
                          color: AppTheme.darkPrimaryColor,
                          border:
                              Border.all(color: AppTheme.darkTextColorPrymary),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: CustomText(
                          text: "Back",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 0.01,
                )
              ],
            ),
          );
        },
      )),
    );
  }
}
