import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zyra_momments_app/app/application/features/profile/bloc/profile_bloc.dart';
import 'package:zyra_momments_app/app/application/features/profile/sub_screens/event_host/host_event_screen/host_event_screen.dart';
import 'package:zyra_momments_app/app/application/features/profile/sub_screens/transaction/transaction_screen.dart';
import 'package:zyra_momments_app/app/application/features/profile/sub_screens/wallet/blocs/wallet_bloc/bloc/wallet_bloc_bloc.dart';
import 'package:zyra_momments_app/app/application/features/profile/sub_screens/wallet/wallet_screen.dart';
import 'package:zyra_momments_app/app/application/features/profile/widgets/build_booking_tile.dart';
import 'package:zyra_momments_app/app/application/features/profile/widgets/build_event_tile.dart';
import 'package:zyra_momments_app/app/application/features/profile/widgets/build_logout_tile.dart';
import 'package:zyra_momments_app/app/application/features/profile/widgets/tile_info_card.dart';
import 'package:zyra_momments_app/application/config/theme.dart';

import 'package:zyra_momments_app/application/core/user_info.dart';

Widget buildProfileActionsSection(BuildContext context, double height) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: height * 0.48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1, color: AppTheme.darkBorderColor),
        ),
        child: Column(
          children: [
            SizedBox(height: height * 0.0025),
            buildEventsTile(context),
            buildBookingTile(context),
            _buildHostEventsTile(context),
            _buildWalletTile(context),
            _buildTransactionsTile(context),
            buildLogoutTile(context),
          ],
        ),
      ),
    );
  }





  Widget _buildHostEventsTile(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileSuccessState) {
          final user = state.user;
          if (user.masterOfCeremonies == true) {
            return GestureDetector(
              onTap: () async {
                final userMap = await SecureStorageHelper.loadUser();
                final firstName = userMap['first_name'];
                final lastName = userMap['last_name'];
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => HostEventScreen(
                      firstName ?? '',
                      lastName ?? '',
                    ),
                  ),
                );
              },
              child:  TileInfoCard(
                leadingIcon: Icons.swap_horiz_outlined,
                label: "Host Events",
                trailingIcon: Icons.arrow_forward_ios_rounded,
              ),
            );
          }
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildWalletTile(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (_) => WalletBlocBloc()..add(GetWalletRequestEvent()),
                ),
              ],
              child: const WalletScreen(),
            ),
          ),
        );
      },
      child:  TileInfoCard(
        leadingIcon: Icons.swap_horiz_outlined,
        label: "Wallet",
        trailingIcon: Icons.arrow_forward_ios_rounded,
      ),
    );
  }

  Widget _buildTransactionsTile(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const TransactionScreen()),
        );
      },
      child:  TileInfoCard(
        leadingIcon: Icons.swap_horiz_outlined,
        label: "Transactions",
        trailingIcon: Icons.arrow_forward_ios_rounded,
      ),
    );
  }

  