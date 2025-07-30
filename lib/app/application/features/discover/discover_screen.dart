// Updated DiscoverScreen using BLoC
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zyra_momments_app/app/application/core/contents/contents.dart';
import 'package:zyra_momments_app/app/application/features/discover/bloc/discover_bloc.dart';
import 'package:zyra_momments_app/app/application/features/discover/sub_screens/discover_sub_screen.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';
import 'package:zyra_momments_app/application/config/widgets/primary_button.dart';
import 'package:zyra_momments_app/application/features/dashboard/dashboard_screen.dart';
import 'package:zyra_momments_app/application/features/dashboard/navigation/bloc/navigation_bloc.dart';
import 'package:zyra_momments_app/application/features/dashboard/navigation/bloc/navigation_tab.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DiscoverBloc()..add(StartAnimationEvent()),
      child: const DiscoverScreenContent(),
    );
  }
}

class DiscoverScreenContent extends StatelessWidget {
  const DiscoverScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    // var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: BlocBuilder<DiscoverBloc, DiscoverState>(
        builder: (context, state) {
          bool animate = false;

          if (state is DiscoverAnimating) {
            animate = state.animate;
          }

          return Stack(
            children: [
              // Background Image
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/discover_6.png"),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),

              // Black Overlay
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black.withOpacity(0.4),
              ),

              // Animated Text Content
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.13),
                    AnimatedSlide(
                      duration: const Duration(milliseconds: 800),
                      offset: animate ? Offset.zero : const Offset(1.2, 0),
                      curve: Curves.easeOut,
                      child: CustomText(
                        text: "Setting up events and\n ticketing made easy!",
                        fontSize: 37,
                        fontWeight: FontWeight.w800,
                        FontFamily: "amaranth",
                      ),
                    ),
                    SizedBox(height: height * 0.030),
                    AnimatedSlide(
                      duration: const Duration(milliseconds: 900),
                      offset: animate ? Offset.zero : const Offset(1.5, 0),
                      curve: Curves.easeOut,
                      child: CustomText(
                        text: content,
                        maxLines: 6,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        FontFamily: "amaranth",
                      ),
                    ),
                    const Spacer(),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 1000),
                      opacity: animate ? 1 : 0,
                      child: PrimaryButton(
                          label: "Start Hosting",
                          ontap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DiscoverSubScreen()));
                          }),
                    ),
                    const SizedBox(height: 10),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 1200),
                      opacity: animate ? 1 : 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  context.read<NavigationBloc>().add(
                                      NavigationTabChanged(
                                          NavigationTab.events));
                                  return DashBoardScreen();
                                },
                              ),
                              (Route<dynamic> route) => false,
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            height: height * 0.055,
                            decoration: BoxDecoration(
                              color: AppTheme.darkPrimaryColor,
                              border: Border.all(
                                  color: AppTheme.darkTextColorPrymary),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: CustomText(
                              text: "Discover Events",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
