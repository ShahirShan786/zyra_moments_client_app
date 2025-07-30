import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zyra_momments_app/app/application/features/profile/widgets/tile_info_card.dart';
import 'package:zyra_momments_app/application/config/widgets/custom_snackbars.dart';
import 'package:zyra_momments_app/application/features/auth/auth_screen.dart';
import 'package:zyra_momments_app/application/features/log_out/bloc/log_out_bloc.dart';

Widget buildLogoutTile(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    
    return BlocListener<LogOutBloc, LogOutState>(
      listener: (context, state) {
        if (state is LogOutLoadingState) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        } else if (state is LogOutFailureState) {
          
          showSuccessSnackbar(context: context, height: height, title: "Log out successful", body: "Successfully log out. Please visit again");
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const AuthScreen()),
            (Route<dynamic> route) => false,
          );
        }
      },
      child: InkWell(
        onTap: () {
          showLogoutConfirmationDialog(context, () {
            BlocProvider.of<LogOutBloc>(context).add(LogoutRequestEvent());
          });
        },
        child:  TileInfoCard(
          leadingIcon: Icons.logout_outlined,
          label: "Log Out",
          trailingIcon: Icons.arrow_forward_ios_rounded,
        ),
      ),
    );
  }


void showLogoutConfirmationDialog(BuildContext context, VoidCallback onConfirm) {
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoTheme(
        data: CupertinoThemeData(
          brightness: Brightness.dark,
          primaryColor: CupertinoColors.systemRed,
          scaffoldBackgroundColor: CupertinoColors.black,
          textTheme: CupertinoTextThemeData(
            textStyle: const TextStyle(color: CupertinoColors.white),
            actionTextStyle: const TextStyle(color: CupertinoColors.systemRed),
          ),
        ),
        child: CupertinoAlertDialog(
          title: const Text('Logout', style: TextStyle(color: CupertinoColors.white)),
          content: const Text('Are you sure you want to logout?',
              style: TextStyle(color: CupertinoColors.white)),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: const Text('Logout'),
              onPressed: () {
                context.read<LogOutBloc>().add(LogoutRequestEvent());
                onConfirm();
              },
            ),
          ],
        ),
      );
    },
  );
}