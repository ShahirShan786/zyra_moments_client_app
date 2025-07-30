import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zyra_momments_app/app/application/features/profile/bloc/profile_bloc.dart';
import 'package:zyra_momments_app/app/application/features/profile/sub_screens/profile_update_screen/profile_update_screen.dart';
import 'package:zyra_momments_app/app/application/features/profile/widgets/detail_card.dart';
import 'package:zyra_momments_app/app/application/features/profile/widgets/info_card.dart';
import 'package:zyra_momments_app/app/application/features/profile/widgets/profile_shimmer.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

Widget buildProfileInfoSection(
    BuildContext context, double height, double width) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
      width: double.infinity,
      height: height * 0.27,
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
          color: AppTheme.darkSecondaryColor,
          borderRadius: BorderRadius.circular(8)),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child:
              BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
            if (state is ProfileLoadingState) {
              return ProfileShimmer(height: height, width: width);
            } else if (state is ProfileFailueState) {
              return Center(
                child: CustomText(text: state.errorMessage),
              );
            } else if (state is ProfileSuccessState) {
              final user = state.user;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // for holding profile image , name and edit button
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.01),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
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
                        SizedBox(
                          width: width * 0.70,
                          child: Padding(
                            padding: EdgeInsets.only(left: width * 0.04),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: "${user.firstName} ${user.lastName}",
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                                IconButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  ProfileUpdateScreen(
                                                    vendorId: user.id,
                                                  )))
                                          .then((_) {
                                        context
                                            .read<ProfileBloc>()
                                            .add(FetchProfileEvent());
                                      });
                                    },
                                    icon: Icon(
                                      Icons.edit_calendar_outlined,
                                      color: AppTheme.darkTextColorSecondary,
                                    ))
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    // for holding user details
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DetailCard(
                              width: width,
                              icon: Icons.phone_outlined,
                              label: "Phone"),
                          DetailCard(
                              width: width,
                              icon: Icons.calendar_today,
                              label: "Joined"),
                        ],
                      ),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InfoCard(
                            info: " ${user.phoneNumber}",
                          ),
                          InfoCard(
                              info:
                                  " ${user.createdAt.day}-${user.createdAt.month}-${user.createdAt.year}"),
                        ],
                      ),
                      SizedBox(
                        width: width * 0.04,
                      ),
                      Spacer(),
                      Row(
                        children: [
                          DetailCard(
                              width: width,
                              icon: Icons.work_history_outlined,
                              label: "Status"),
                          CustomText(
                            text: " : Active",
                            color: Colors.green,
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      DetailCard(
                          width: width,
                          icon: Icons.email_outlined,
                          label: "Email"),
                      SizedBox(
                        width: width * 0.04,
                      ),
                      InfoCard(info: " ${user.email}")
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: width * 0.45,
                        height: height * 0.05,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "Additional Info",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(
                              height: height * 0.008,
                            ),
                            Expanded(
                                child: CustomText(
                              text: user.masterOfCeremonies
                                  ? "Master of Ceremonies"
                                  : "Not a Master of Ceremonies",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              color: AppTheme.darkTextColorSecondary,
                              fontSize: 13,
                            ))
                          ],
                        ),
                      ),
                      SizedBox(
                        width: width * 0.30,
                        height: height * 0.05,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "Location",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(
                              height: height * 0.008,
                            ),
                            Expanded(
                              child: CustomText(
                                text: (user.place != null &&
                                        user.place!.trim().isNotEmpty)
                                    ? user.place!
                                    : "Not added",
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                color: AppTheme.darkTextColorSecondary,
                                fontSize: 13,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              );
            }
            return SizedBox(
              child: Text("Something went wrong"),
            );
          })),
    ),
  );
}

  // Widget _buildProfileShimmer(BuildContext context) {
  //   final height = MediaQuery.of(context).size.height;
  //   final width = MediaQuery.of(context).size.width;
    
  //   return ProfileShimmer(height: height, width: width);
  // }

  // Widget _buildProfileContent(BuildContext context, dynamic user) {
  //   final height = MediaQuery.of(context).size.height;
  //   final width = MediaQuery.of(context).size.width;
    
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       _buildProfileHeader(context, user, width, height),
  //       _buildUserDetailsRow(context, user, width),
  //       _buildEmailRow(context, user, width),
  //       SizedBox(height: height * 0.01),
  //       _buildAdditionalInfoRow(context, user, width),
  //     ],
  //   );
  // }

  // Widget _buildProfileHeader(BuildContext context, dynamic user, double width, double height) {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(vertical: height * 0.01),
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         _buildProfileAvatar(user),
  //         SizedBox(width: width * 0.04),
  //         _buildProfileNameAndEditButton(context, user, width),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildProfileAvatar(dynamic user) {
  //   return CircleAvatar(
  //     backgroundColor: AppTheme.darkBoxColor,
  //     radius: 40,
  //     backgroundImage: user.profileImage != null && user.profileImage!.isNotEmpty
  //         ? NetworkImage(user.profileImage!)
  //         : null,
  //     child: user.profileImage == null || user.profileImage!.isEmpty
  //         ? Center(
  //             child: CustomText(
  //               text: "${user.firstName[0].toUpperCase()}${user.lastName[0].toUpperCase()}",
  //               fontSize: 25,
  //               color: AppTheme.darkTextColor,
  //               fontWeight: FontWeight.w600,
  //             ),
  //           )
  //         : null,
  //   );
  // }

  // Widget _buildProfileNameAndEditButton(BuildContext context, dynamic user, double width) {
  //   return SizedBox(
  //     width: width * 0.70,
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         CustomText(
  //           text: "${user.firstName} ${user.lastName}",
  //           fontSize: 26,
  //           fontWeight: FontWeight.bold,
  //         ),
  //         IconButton(
  //           onPressed: () {
  //             Navigator.of(context)
  //                 .push(MaterialPageRoute(
  //                     builder: (context) => ProfileUpdateScreen(vendorId: user.id)))
  //                 .then((_) {
  //               context.read<ProfileBloc>().add(FetchProfileEvent());
  //             });
  //           },
  //           icon: Icon(
  //             Icons.edit_calendar_outlined,
  //             color: AppTheme.darkTextColorSecondary,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildUserDetailsRow(BuildContext context, dynamic user, double width) {
  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           DetailCard(
  //             width: width,
  //             icon: Icons.phone_outlined,
  //             label: "Phone",
  //           ),
  //           DetailCard(
  //             width: width,
  //             icon: Icons.calendar_today,
  //             label: "Joined",
  //           ),
  //         ],
  //       ),
  //       SizedBox(width: width * 0.02),
  //       Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           InfoCard(info: " ${user.phoneNumber}"),
  //           InfoCard(info: " ${user.createdAt.day}-${user.createdAt.month}-${user.createdAt.year}"),
  //         ],
  //       ),
  //       SizedBox(width: width * 0.04),
  //       const Spacer(),
  //       Row(
  //         children: [
  //           DetailCard(
  //             width: width,
  //             icon: Icons.work_history_outlined,
  //             label: "Status",
  //           ),
  //           const CustomText(
  //             text: " : Active",
  //             color: Colors.green,
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildEmailRow(BuildContext context, dynamic user, double width) {
  //   return Row(
  //     children: [
  //       DetailCard(
  //         width: width,
  //         icon: Icons.email_outlined,
  //         label: "Email",
  //       ),
  //       SizedBox(width: width * 0.04),
  //       InfoCard(info: " ${user.email}"),
  //     ],
  //   );
  // }

  // Widget _buildAdditionalInfoRow(BuildContext context, dynamic user, double width) {
  //   final height = MediaQuery.of(context).size.height;
    
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       SizedBox(
  //         width: width * 0.45,
  //         height: height * 0.05,
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             const CustomText(
  //               text: "Additional Info",
  //               fontSize: 15,
  //               fontWeight: FontWeight.w500,
  //             ),
  //             SizedBox(height: height * 0.008),
  //             Expanded(
  //               child: CustomText(
  //                 text: user.masterOfCeremonies
  //                     ? "Master of Ceremonies"
  //                     : "Not a Master of Ceremonies",
  //                 maxLines: 3,
  //                 overflow: TextOverflow.ellipsis,
  //                 color: AppTheme.darkTextColorSecondary,
  //                 fontSize: 13,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //       SizedBox(
  //         width: width * 0.30,
  //         height: height * 0.05,
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             const CustomText(
  //               text: "Location",
  //               fontSize: 15,
  //               fontWeight: FontWeight.w500,
  //             ),
  //             SizedBox(height: height * 0.008),
  //             Expanded(
  //               child: CustomText(
  //                 text: (user.place != null && user.place!.trim().isNotEmpty)
  //                     ? user.place!
  //                     : "Not added",
  //                 maxLines: 3,
  //                 overflow: TextOverflow.ellipsis,
  //                 color: AppTheme.darkTextColorSecondary,
  //                 fontSize: 13,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }