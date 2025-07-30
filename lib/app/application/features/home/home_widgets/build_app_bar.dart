  import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zyra_momments_app/app/application/features/home/chat/chat_screens/chat_listing_screen/chat_listing_screen.dart';
import 'package:zyra_momments_app/app/application/features/home/sub_screen/qr_scanning_button/scanning_button.dart';
import 'package:zyra_momments_app/app/application/features/profile/bloc/profile_bloc.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';
import 'package:zyra_momments_app/application/core/user_info.dart';

AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF18181b),
      iconTheme: IconThemeData(color: AppTheme.darkTextColor),
      centerTitle: true,
      title: CustomText(
        text: "ZYRA MOMENTS",
        fontSize: 25,
        FontFamily: 'shafarik',
      ),
      actions: [
        _buildQrScannerButton(),
        _buildMessageButton(context),
      ],
    );
  }

  Widget _buildQrScannerButton() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileSuccessState &&
            state.user.masterOfCeremonies == true) {
          return IconButton(
            onPressed: () => showQrScanOptions(context),
            icon: Icon(Icons.qr_code_scanner),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildMessageButton(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final userData = await SecureStorageHelper.loadUser();
        final userId = userData['id'];
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ChatListingScreen(
            userId: userId!,
            userType: 'Client',
          ),
        ));
      },
      icon: Icon(Icons.message),
    );
  }