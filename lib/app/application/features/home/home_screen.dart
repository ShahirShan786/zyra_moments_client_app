import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zyra_momments_app/app/application/features/events/bloc/event_bloc.dart';
import 'package:zyra_momments_app/app/application/features/home/blocs/best_vendor_bloc/bloc/best_vendor_bloc.dart';
import 'package:zyra_momments_app/app/application/features/home/blocs/bloc/home_bloc.dart';
import 'package:zyra_momments_app/app/application/features/home/home_widgets/build_app_bar.dart';
import 'package:zyra_momments_app/app/application/features/home/home_widgets/build_categorie_section.dart';
import 'package:zyra_momments_app/app/application/features/home/home_widgets/build_content_section.dart';
import 'package:zyra_momments_app/app/application/features/home/home_widgets/build_hero_section.dart';
import 'package:zyra_momments_app/app/application/features/home/home_widgets/build_vendor_section.dart';
import 'package:zyra_momments_app/app/application/features/home/sub_screen/privacy_policy/privacy_policy_screen.dart';
import 'package:zyra_momments_app/app/application/features/home/sub_screen/terms_and_condition/terms_and_condition_screen.dart';
import 'package:zyra_momments_app/app/application/features/profile/bloc/profile_bloc.dart';
import 'package:zyra_momments_app/app/application/features/profile/sub_screens/booking_status_screen/booking_status_screen.dart';
import 'package:zyra_momments_app/app/application/features/profile/sub_screens/wallet/wallet_screen.dart';
import 'package:zyra_momments_app/app/application/features/profile/widgets/build_logout_tile.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';
import 'package:zyra_momments_app/application/config/widgets/custom_snackbars.dart';
import 'package:zyra_momments_app/application/features/auth/auth_screen.dart';
import 'package:zyra_momments_app/application/features/log_out/bloc/log_out_bloc.dart';
import 'package:zyra_momments_app/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with RouteAware {
  @override
  void initState() {
    super.initState();
    _fetchInitialData();
  }

  void _fetchInitialData() {
    context.read<HomeBloc>().add(GetCategoryRequestEvent());
    context.read<BestVendorBloc>().add(GetBestVendorRequestEvent());
    context.read<EventBloc>().add(GetAllEventRequest());
    context.read<ProfileBloc>().add(FetchProfileEvent());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)! as PageRoute);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    context.read<HomeBloc>().add(GetCategoryRequestEvent());
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildHeroSection(context),
            buildContentSection(context),
            // SizedBox(height: height * 0.02),

            // buildEventsHeaderSection(),
            // SizedBox(height: height * 0.02),
            // buildEventsDescriptionSection(),
            // // SizedBox(
            // //   width: double.infinity,
            // //   child: CustomText(
            // //     text:
            // //         "Discover the hottest upcoming events in your area. From conferences to festivals, we've got you covered with the most exciting gatherings on the horizon.",
            // //     fontSize: 16,
            // //     maxLines: 4,
            // //     fontWeight: FontWeight.w400,
            // //   ),
            // // ),
            // // SizedBox(height: height * 0.07),
            // buildEventActionButtons(width, height),
            // buildEventsGridSection(),
            // buildVendorsSection(width, height),
          ],
        ),
      ),
      // body: Center(
      //   child: CustomText(text: "Home screen"),
      // ),
      drawer: Drawer(
        backgroundColor: AppTheme.darkPrimaryColor,
        child: BlocListener<LogOutBloc, LogOutState>(
          listener: (context, state) {
            if (state is LogOutSuccessState) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => AuthScreen()),
                (Route<dynamic> route) => false,
              );
            } else if (state is LogOutFailureState) {
              showFailureScackbar(
                  context: context,
                  height: height,
                  title: "Logout Filed",
                  body: state.errorMessage);
            }
          },
          child: Column(
            children: [
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is ProfileFailueState) {
                    return Center(
                      child: CustomText(text: state.errorMessage),
                    );
                  } else if (state is ProfileSuccessState) {
                    final user = state.user;
                    return UserAccountsDrawerHeader(
                      accountName: CustomText(
                          text: "${user.firstName} ${user.lastName}"),
                      accountEmail: CustomText(text: user.email),
                      currentAccountPicture: CircleAvatar(
                        backgroundColor: AppTheme.darkBoxColor,
                        radius: 40,
                        backgroundImage: user.profileImage != null &&
                                user.profileImage!.isNotEmpty
                            ? NetworkImage(user.profileImage!)
                            : null,
                        child: user.profileImage == null ||
                                user.profileImage!.isEmpty
                            ? Center(
                                child: CustomText(
                                  text:
                                      "${user.firstName[0].toUpperCase()}${user.lastName[0].toUpperCase()}",
                                  fontSize: 25,
                                  color: AppTheme.darkTextColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            : null,
                      ),
                      decoration:
                          BoxDecoration(color: AppTheme.darkSecondaryColor),
                    );
                  }
                  return CustomText(text: "asdjfasdfdsf");
                },
              ),

              ListTile(
                leading: Icon(
                  Icons.home,
                  color: AppTheme.darkTextColorSecondary,
                ),
                title: CustomText(text: "Home"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.list_alt,
                  color: AppTheme.darkTextColorSecondary,
                ),
                title: CustomText(text: "Booking"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BookingStatusScreen()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.wallet,
                  color: AppTheme.darkTextColorSecondary,
                ),
                title: CustomText(text: "Wallet"),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WalletScreen()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.security_rounded,
                  color: AppTheme.darkTextColorSecondary,
                ),
                title: CustomText(text: "Privacy policy"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PrivacyPolicyScreen()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.edit_document,
                  color: AppTheme.darkTextColorSecondary,
                ),
                title: CustomText(text: "Terms and Conditions"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TermsConditionsScreen()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: AppTheme.darkTextColorSecondary,
                ),
                title: CustomText(text: "Settings"),
                onTap: () {
                  // Navigate to settings page
                },
              ),
              const Spacer(), // pushes the logout button to the bottom
              const Divider(),
              ListTile(
                leading: Icon(
                  Icons.logout,
                  color: AppTheme.darkTextColorSecondary,
                ),
                title: CustomText(text: "Log out"),
                onTap: () {
                  showLogoutConfirmationDialog(context, () {
                    BlocProvider.of<LogOutBloc>(context)
                        .add(LogoutRequestEvent());
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:zyra_momments_app/app/application/features/events/bloc/event_bloc.dart';
// import 'package:zyra_momments_app/app/application/features/home/blocs/best_vendor_bloc/bloc/best_vendor_bloc.dart';
// import 'package:zyra_momments_app/app/application/features/home/blocs/bloc/home_bloc.dart';
// import 'package:zyra_momments_app/app/application/features/home/home_widgets/build_app_bar.dart';
// import 'package:zyra_momments_app/app/application/features/home/home_widgets/build_content_section.dart';
// import 'package:zyra_momments_app/app/application/features/home/home_widgets/build_hero_section.dart';
// import 'package:zyra_momments_app/app/application/features/home/sub_screen/privacy_policy/privacy_policy_screen.dart';
// import 'package:zyra_momments_app/app/application/features/home/sub_screen/terms_and_condition/terms_and_condition_screen.dart';
// import 'package:zyra_momments_app/app/application/features/profile/bloc/profile_bloc.dart';
// import 'package:zyra_momments_app/app/application/features/profile/sub_screens/booking_status_screen/booking_status_screen.dart';
// import 'package:zyra_momments_app/app/application/features/profile/sub_screens/wallet/wallet_screen.dart';
// import 'package:zyra_momments_app/app/application/features/profile/widgets/build_logout_tile.dart';
// import 'package:zyra_momments_app/application/config/theme.dart';
// import 'package:zyra_momments_app/application/config/widgets/app_text.dart';
// import 'package:zyra_momments_app/application/config/widgets/custom_snackbars.dart';
// import 'package:zyra_momments_app/application/features/auth/auth_screen.dart';
// import 'package:zyra_momments_app/application/features/log_out/bloc/log_out_bloc.dart';
// import 'package:zyra_momments_app/main.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> with RouteAware {
//   @override
//   void initState() {
//     super.initState();
//     _fetchInitialData();
//   }

//   void _fetchInitialData() {
//     context.read<HomeBloc>().add(GetCategoryRequestEvent());
//     context.read<BestVendorBloc>().add(GetBestVendorRequestEvent());
//     context.read<EventBloc>().add(GetAllEventRequest());
//     context.read<ProfileBloc>().add(FetchProfileEvent());
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     routeObserver.subscribe(this, ModalRoute.of(context)! as PageRoute);
//   }

//   @override
//   void dispose() {
//     routeObserver.unsubscribe(this);
//     super.dispose();
//   }

//   @override
//   void didPopNext() {
//     context.read<HomeBloc>().add(GetCategoryRequestEvent());
//   }

//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       appBar: buildAppBar(context),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // buildHeroSection(context),
//             // buildContentSection(context),
//           ],
//         ),
//       ),
//       // body: Center(
//       //   child: CustomText(text: "Home screen"),
//       // ),
//       drawer: Drawer(
//         backgroundColor: AppTheme.darkPrimaryColor,
//         child: BlocListener<LogOutBloc, LogOutState>(
//           listener: (context, state) {
//             if (state is LogOutSuccessState) {
//               Navigator.pushAndRemoveUntil(
//                 context,
//                 MaterialPageRoute(builder: (context) => AuthScreen()),
//                 (Route<dynamic> route) => false,
//               );
//             } else if (state is LogOutFailureState) {
//               showFailureScackbar(
//                   context: context,
//                   height: height,
//                   title: "Logout Filed",
//                   body: state.errorMessage);
//             }
//           },
//           child: Column(
//             children: [
//               BlocBuilder<ProfileBloc, ProfileState>(
//                 builder: (context, state) {
//                   if (state is ProfileLoadingState) {
//                     return Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   } else if (state is ProfileFailueState) {
//                     return Center(
//                       child: CustomText(text: state.errorMessage),
//                     );
//                   } else if (state is ProfileSuccessState) {
//                     final user = state.user;
//                     return UserAccountsDrawerHeader(
//                       accountName: CustomText(
//                           text: "${user.firstName} ${user.lastName}"),
//                       accountEmail: CustomText(text: user.email),
//                       currentAccountPicture: CircleAvatar(
//                         backgroundColor: AppTheme.darkBoxColor,
//                         radius: 40,
//                         backgroundImage: user.profileImage != null &&
//                                 user.profileImage!.isNotEmpty
//                             ? NetworkImage(user.profileImage!)
//                             : null,
//                         child: user.profileImage == null ||
//                                 user.profileImage!.isEmpty
//                             ? Center(
//                                 child: CustomText(
//                                   text:
//                                       "${user.firstName[0].toUpperCase()}${user.lastName[0].toUpperCase()}",
//                                   fontSize: 25,
//                                   color: AppTheme.darkTextColor,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               )
//                             : null,
//                       ),
//                       decoration:
//                           BoxDecoration(color: AppTheme.darkSecondaryColor),
//                     );
//                   }
//                   return CustomText(text: "asdjfasdfdsf");
//                 },
//               ),

//               ListTile(
//                 leading: Icon(
//                   Icons.home,
//                   color: AppTheme.darkTextColorSecondary,
//                 ),
//                 title: CustomText(text: "Home"),
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 leading: Icon(
//                   Icons.list_alt,
//                   color: AppTheme.darkTextColorSecondary,
//                 ),
//                 title: CustomText(text: "Booking"),
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => BookingStatusScreen()));
//                 },
//               ),
//               ListTile(
//                 leading: Icon(
//                   Icons.wallet,
//                   color: AppTheme.darkTextColorSecondary,
//                 ),
//                 title: CustomText(text: "Wallet"),
//                 onTap: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => WalletScreen()));
//                 },
//               ),
//               ListTile(
//                 leading: Icon(
//                   Icons.security_rounded,
//                   color: AppTheme.darkTextColorSecondary,
//                 ),
//                 title: CustomText(text: "Privacy policy"),
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => PrivacyPolicyScreen()));
//                 },
//               ),
//               ListTile(
//                 leading: Icon(
//                   Icons.edit_document,
//                   color: AppTheme.darkTextColorSecondary,
//                 ),
//                 title: CustomText(text: "Terms and Conditions"),
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => TermsConditionsScreen()));
//                 },
//               ),
//               ListTile(
//                 leading: Icon(
//                   Icons.settings,
//                   color: AppTheme.darkTextColorSecondary,
//                 ),
//                 title: CustomText(text: "Settings"),
//                 onTap: () {
//                   // Navigate to settings page
//                 },
//               ),
//               const Spacer(), // pushes the logout button to the bottom
//               const Divider(),
//               ListTile(
//                 leading: Icon(
//                   Icons.logout,
//                   color: AppTheme.darkTextColorSecondary,
//                 ),
//                 title: CustomText(text: "Log out"),
//                 onTap: () {
//                   showLogoutConfirmationDialog(context, () {
//                     BlocProvider.of<LogOutBloc>(context)
//                         .add(LogoutRequestEvent());
//                   });
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
