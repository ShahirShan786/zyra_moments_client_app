import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zyra_momments_app/app/application/features/profile/bloc/profile_bloc.dart';
import 'package:zyra_momments_app/app/application/features/profile/widgets/build_profile_action_section.dart';
import 'package:zyra_momments_app/app/application/features/profile/widgets/build_profile_info_section.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc()..add(FetchProfileEvent()),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(context),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: CustomText(
        text: "Profile",
        fontSize: 25,
        FontFamily: 'shafarik',
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            buildProfileInfoSection(context , height , width ),
            buildProfileActionsSection(context, height),
          ],
        ),
      ),
    );
  }
}

  








// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:zyra_momments_app/app/application/features/profile/bloc/profile_bloc.dart';
// import 'package:zyra_momments_app/app/application/features/profile/sub_screens/booking_status_screen/booking_status_screen.dart';
// import 'package:zyra_momments_app/app/application/features/profile/sub_screens/event_host/host_event_screen/host_event_screen.dart';
// import 'package:zyra_momments_app/app/application/features/profile/sub_screens/profile_update_screen/profile_update_screen.dart';
// import 'package:zyra_momments_app/app/application/features/profile/sub_screens/purchased_event_screen/purchased_event_screen.dart';
// import 'package:zyra_momments_app/app/application/features/profile/sub_screens/transaction/transaction_screen.dart';
// import 'package:zyra_momments_app/app/application/features/profile/sub_screens/wallet/blocs/wallet_bloc/bloc/wallet_bloc_bloc.dart';
// import 'package:zyra_momments_app/app/application/features/profile/sub_screens/wallet/wallet_screen.dart';
// import 'package:zyra_momments_app/app/application/features/profile/widgets/tile_info_card.dart';
// import 'package:zyra_momments_app/application/config/theme.dart';
// import 'package:zyra_momments_app/application/config/widgets/app_text.dart';
// import 'package:zyra_momments_app/application/config/widgets/custom_snackbars.dart';
// import 'package:zyra_momments_app/application/core/user_info.dart';
// import 'package:zyra_momments_app/application/features/auth/auth_screen.dart';
// import 'package:zyra_momments_app/application/features/log_out/bloc/log_out_bloc.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height;

//     return BlocProvider(
//       create: (context) => ProfileBloc()..add(FetchProfileEvent()),
//       child: Scaffold(
//           appBar: AppBar(
//             centerTitle: true,
//             title: CustomText(
//               text: "Profile",
//               fontSize: 25,
//               FontFamily: 'shafarik',
//             ),
//           ),
//           body: SingleChildScrollView(
//             child: SizedBox(
//               width: double.infinity,
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Container(
//                       width: double.infinity,
//                       height: height * 0.27,
//                       padding: EdgeInsets.all(2),
//                       decoration: BoxDecoration(
//                           color: AppTheme.darkSecondaryColor,
//                           borderRadius: BorderRadius.circular(8)),
//                       child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 5),
//                           child: BlocBuilder<ProfileBloc, ProfileState>(
//                               builder: (context, state) {
//                             if (state is ProfileLoadingState) {
//                               return ProfileShimmer(
//                                   height: height, width: width);
//                             } else if (state is ProfileFailueState) {
//                               return Center(
//                                 child: CustomText(text: state.errorMessage),
//                               );
//                             } else if (state is ProfileSuccessState) {
//                               final user = state.user;
//                               return Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   // for holding profile image , name and edit button
//                                   Padding(
//                                     padding: EdgeInsets.symmetric(
//                                         vertical: height * 0.01),
//                                     child: Row(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         CircleAvatar(
//                                           backgroundColor:
//                                               AppTheme.darkBoxColor,
//                                           radius: 40,
//                                           backgroundImage: user.profileImage !=
//                                                       null &&
//                                                   user.profileImage!.isNotEmpty
//                                               ? NetworkImage(user.profileImage!)
//                                               : null,
//                                           child: user.profileImage == null ||
//                                                   user.profileImage!.isEmpty
//                                               ? Center(
//                                                   child: CustomText(
//                                                     text:
//                                                         "${user.firstName[0].toUpperCase()}${user.lastName[0].toUpperCase()}",
//                                                     fontSize: 25,
//                                                     color:
//                                                         AppTheme.darkTextColor,
//                                                     fontWeight: FontWeight.w600,
//                                                   ),
//                                                 )
//                                               : null,
//                                         ),
//                                         SizedBox(
//                                           width: width * 0.70,
//                                           child: Padding(
//                                             padding: EdgeInsets.only(
//                                                 left: width * 0.04),
//                                             child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 CustomText(
//                                                   text:
//                                                       "${user.firstName} ${user.lastName}",
//                                                   fontSize: 26,
//                                                   fontWeight: FontWeight.bold,
//                                                 ),
//                                                 IconButton(
//                                                     onPressed: () {
//                                                       Navigator.of(context)
//                                                           .push(
//                                                               MaterialPageRoute(
//                                                                   builder:
//                                                                       (context) =>
//                                                                           ProfileUpdateScreen(
//                                                                             vendorId:
//                                                                                 user.id,
//                                                                           )))
//                                                           .then((_) {
//                                                         context
//                                                             .read<ProfileBloc>()
//                                                             .add(
//                                                                 FetchProfileEvent());
//                                                       });
//                                                     },
//                                                     icon: Icon(
//                                                       Icons
//                                                           .edit_calendar_outlined,
//                                                       color: AppTheme
//                                                           .darkTextColorSecondary,
//                                                     ))
//                                               ],
//                                             ),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                   Row(
//                                     // for holding user details
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,

//                                     children: [
//                                       Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           DetailCard(
//                                               width: width,
//                                               icon: Icons.phone_outlined,
//                                               label: "Phone"),
//                                           DetailCard(
//                                               width: width,
//                                               icon: Icons.calendar_today,
//                                               label: "Joined"),
//                                         ],
//                                       ),
//                                       SizedBox(
//                                         width: width * 0.02,
//                                       ),
//                                       Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           InfoCard(
//                                             info: " ${user.phoneNumber}",
//                                           ),
//                                           InfoCard(
//                                               info:
//                                                   " ${user.createdAt.day}-${user.createdAt.month}-${user.createdAt.year}"),
//                                         ],
//                                       ),
//                                       SizedBox(
//                                         width: width * 0.04,
//                                       ),
//                                       Spacer(),
//                                       Row(
//                                         children: [
//                                           DetailCard(
//                                               width: width,
//                                               icon: Icons.work_history_outlined,
//                                               label: "Status"),
//                                           CustomText(
//                                             text: " : Active",
//                                             color: Colors.green,
//                                           )
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       DetailCard(
//                                           width: width,
//                                           icon: Icons.email_outlined,
//                                           label: "Email"),
//                                       SizedBox(
//                                         width: width * 0.04,
//                                       ),
//                                       InfoCard(info: " ${user.email}")
//                                     ],
//                                   ),
//                                   SizedBox(
//                                     height: height * 0.01,
//                                   ),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       SizedBox(
//                                         width: width * 0.45,
//                                         height: height * 0.05,
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             CustomText(
//                                               text: "Additional Info",
//                                               fontSize: 15,
//                                               fontWeight: FontWeight.w500,
//                                             ),
//                                             SizedBox(
//                                               height: height * 0.008,
//                                             ),
//                                             Expanded(
//                                                 child: CustomText(
//                                               text: user.masterOfCeremonies
//                                                   ? "Master of Ceremonies"
//                                                   : "Not a Master of Ceremonies",
//                                               maxLines: 3,
//                                               overflow: TextOverflow.ellipsis,
//                                               color: AppTheme
//                                                   .darkTextColorSecondary,
//                                               fontSize: 13,
//                                             ))
//                                           ],
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: width * 0.30,
//                                         height: height * 0.05,
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             CustomText(
//                                               text: "Location",
//                                               fontSize: 15,
//                                               fontWeight: FontWeight.w500,
//                                             ),
//                                             SizedBox(
//                                               height: height * 0.008,
//                                             ),
//                                             Expanded(
//                                               child: CustomText(
//                                                 text: (user.place != null &&
//                                                         user.place!
//                                                             .trim()
//                                                             .isNotEmpty)
//                                                     ? user.place!
//                                                     : "Not added",
//                                                 maxLines: 3,
//                                                 overflow: TextOverflow.ellipsis,
//                                                 color: AppTheme
//                                                     .darkTextColorSecondary,
//                                                 fontSize: 13,
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   )
//                                 ],
//                               );
//                             }
//                             return SizedBox(
//                               child: Text("Something went wrong"),
//                             );
//                           })),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       width: double.infinity,
//                       height: height * 0.48,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           border: Border.all(
//                               width: 1, color: AppTheme.darkBorderColor)),
//                       child: Column(
//                         children: [
//                           SizedBox(
//                             height: height * 0.0025,
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.of(context).push(MaterialPageRoute(
//                                   builder: (context) =>
//                                       PurchasedEventScreen()));
//                             },
//                             child: TileInfoCard(
//                                 leadingIcon: Icons.swap_horiz_outlined,
//                                 label: "Events",
//                                 trailingIcon: Icons.arrow_forward_ios_rounded),
//                           ),
//                           GestureDetector(
//                             onTap: () =>
//                                 Navigator.of(context).push(MaterialPageRoute(
//                               builder: (context) => BookingStatusScreen(),
//                             )),
//                             child: TileInfoCard(
//                                 leadingIcon: Icons.description_outlined,
//                                 label: "Booking",
//                                 trailingIcon: Icons.arrow_forward_ios_rounded),
//                           ),
//                           BlocBuilder<ProfileBloc, ProfileState>(
//                             builder: (context, state) {
//                               if (state is ProfileSuccessState) {
//                                 final user = state.user;
//                                 if (user.masterOfCeremonies == true) {
//                                   return GestureDetector(
//                                     onTap: () async {
//                                       final userMap =
//                                           await SecureStorageHelper.loadUser();
//                                       final firstName = userMap['first_name'];
//                                       final lastName = userMap['last_name'];
//                                       Navigator.of(context).push(
//                                         MaterialPageRoute(
//                                           builder: (context) => HostEventScreen(
//                                             firstName ?? '',
//                                             lastName ?? '',
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                     child: TileInfoCard(
//                                       leadingIcon: Icons.swap_horiz_outlined,
//                                       label: "Host Events",
//                                       trailingIcon:
//                                           Icons.arrow_forward_ios_rounded,
//                                     ),
//                                   );
//                                 } else {
//                                   return const SizedBox.shrink();
//                                 }
//                               } else {
//                                 return const SizedBox.shrink();
//                               }
//                             },
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (_) => MultiBlocProvider(
//                                       providers: [
//                                         BlocProvider(
//                                             create: (_) => WalletBlocBloc()
//                                               ..add(GetWalletRequestEvent())),
//                                         // your second request
//                                       ],
//                                       child: WalletScreen(),
//                                     ),
//                                   ));
//                             },
//                             child: TileInfoCard(
//                                 leadingIcon: Icons.swap_horiz_outlined,
//                                 label: "Wallet",
//                                 trailingIcon: Icons.arrow_forward_ios_rounded),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.of(context).push(MaterialPageRoute(
//                                   builder: (context) => TransactionScreen()));
//                             },
//                             child: TileInfoCard(
//                                 leadingIcon: Icons.swap_horiz_outlined,
//                                 label: "Transactions",
//                                 trailingIcon: Icons.arrow_forward_ios_rounded),
//                           ),
//                           BlocListener<LogOutBloc, LogOutState>(
//                             listener: (context, state) {
//                               if (state is LogOutLoadingState) {
//                                 showDialog(
//                                   context: context,
//                                   barrierDismissible: false,
//                                   builder: (_) => Center(
//                                     child: CircularProgressIndicator(),
//                                   ),
//                                 );
//                               } else if (state is LogOutFailureState) {
//                                 showSuccessSnackbar(
//                                     context: context,
//                                     height: height,
//                                     title: "Log out successful",
//                                     body:
//                                         "Successfully log out. Please visit again");
//                                 Navigator.pushAndRemoveUntil(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => AuthScreen()),
//                                   (Route<dynamic> route) => false,
//                                 );
//                               }
//                             },
//                             child: InkWell(
//                               onTap: () {
//                                 showLogoutConfirmationDialog(context, () {
//                                   BlocProvider.of<LogOutBloc>(context)
//                                       .add(LogoutRequestEvent());
//                                 });
//                               },
//                               child: TileInfoCard(
//                                   leadingIcon: Icons.logout_outlined,
//                                   label: "Log Out",
//                                   trailingIcon:
//                                       Icons.arrow_forward_ios_rounded),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           )),
//     );
//   }
// }

// void showLogoutConfirmationDialog(
//     BuildContext context, VoidCallback onConfirm) {
//   showCupertinoDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return CupertinoTheme(
//         data: CupertinoThemeData(
//           brightness: Brightness.dark,
//           primaryColor: CupertinoColors.systemRed,
//           scaffoldBackgroundColor: CupertinoColors.black,
//           textTheme: CupertinoTextThemeData(
//             textStyle: TextStyle(color: CupertinoColors.white),
//             actionTextStyle: TextStyle(color: CupertinoColors.systemRed),
//           ),
//         ),
//         child: CupertinoAlertDialog(
//           title: Text('Logout', style: TextStyle(color: CupertinoColors.white)),
//           content: Text('Are you sure you want to logout?',
//               style: TextStyle(color: CupertinoColors.white)),
//           actions: <CupertinoDialogAction>[
//             CupertinoDialogAction(
//               child: Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             CupertinoDialogAction(
//               isDestructiveAction: true,
//               child: Text('Logout'),
//               onPressed: () {
//                 context.read<LogOutBloc>().add(LogoutRequestEvent());

//                 onConfirm();
//               },
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }

// // Shimmer effect for profile loading state
// class ProfileShimmer extends StatelessWidget {
//   final double height;
//   final double width;

//   const ProfileShimmer({required this.height, required this.width, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Shimmer.fromColors(
//       baseColor: AppTheme.darkShimmerBaseColor,
//       highlightColor: AppTheme.darkShimmerHeighlightColor,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Profile image and name shimmer
//           Padding(
//             padding: EdgeInsets.symmetric(vertical: height * 0.01),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Circle avatar shimmer
//                 Container(
//                   width: 80,
//                   height: 80,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//                 SizedBox(width: width * 0.04),
//                 // Name shimmer
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       width: width * 0.4,
//                       height: 25,
//                       color: Colors.white,
//                     ),
//                     SizedBox(height: 5),
//                     Container(
//                       width: width * 0.3,
//                       height: 15,
//                       color: Colors.white,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: height * 0.01),

//           // User details shimmer
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // First column
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildDetailShimmer(width * 0.2, 15),
//                   SizedBox(height: 12),
//                   _buildDetailShimmer(width * 0.2, 15),
//                 ],
//               ),
//               SizedBox(width: width * 0.02),
//               // Second column
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildDetailShimmer(width * 0.3, 15),
//                   SizedBox(height: 12),
//                   _buildDetailShimmer(width * 0.3, 15),
//                 ],
//               ),
//               Spacer(),
//               // Status
//               _buildDetailShimmer(width * 0.2, 15),
//             ],
//           ),
//           SizedBox(height: 12),

//           // Email row shimmer
//           Row(
//             children: [
//               _buildDetailShimmer(width * 0.2, 15),
//               SizedBox(width: width * 0.04),
//               _buildDetailShimmer(width * 0.4, 15),
//             ],
//           ),

//           SizedBox(height: height * 0.01),

//           // Additional info section shimmer
//           _buildDetailShimmer(width * 0.4, 15),
//           SizedBox(height: height * 0.008),
//           _buildDetailShimmer(width * 0.7, 15),
//         ],
//       ),
//     );
//   }

//   Widget _buildDetailShimmer(double width, double height) {
//     return Container(
//       width: width,
//       height: height,
//       color: Colors.white,
//     );
//   }
// }

// class InfoCard extends StatelessWidget {
//   String info;
//   InfoCard({super.key, required this.info});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         CustomText(text: ":"),
//         CustomText(
//           text: info,
//           color: AppTheme.darkTextColorSecondary,
//         )
//       ],
//     );
//   }
// }

// class DetailCard extends StatelessWidget {
//   DetailCard(
//       {super.key,
//       required this.width,
//       required this.icon,
//       required this.label});

//   final double width;
//   IconData icon;
//   String label;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Icon(
//           icon,
//           color: AppTheme.darkIconColor,
//           size: width * 0.048,
//         ),
//         SizedBox(
//           width: width * 0.01,
//         ),
//         CustomText(
//           text: label,
//           fontSize: 16,
//           fontWeight: FontWeight.w500,
//         )
//       ],
//     );
//   }
// }

// String blog =
//     "We are the premier wedding planners in Kerala, dedicated to making your special day truly unforgettable. With our expert team, creative vision, and seamless execution, we bring your dream wedding to life. ";
