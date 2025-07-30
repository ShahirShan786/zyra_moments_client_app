import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:zyra_momments_app/app/application/features/profile/sub_screens/wallet/blocs/wallet_bloc/bloc/wallet_bloc_bloc.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(
          text: "My Wallet",
          fontSize: 25,
          FontFamily: 'roboto',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<WalletBlocBloc, WalletBlocState>(
                builder: (context, state) {
                  if (state is GetWalletLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  } else if (state is GetWalletFailureState) {
                    return Center(
                      child: CustomText(text: state.errorMessage),
                    );
                  } else if (state is GetWalletSuccessState) {
                    final walletData = state.walletData;
                    final paymentList = walletData.paymentId;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(8),
                          height: height * 0.21,
                          decoration: BoxDecoration(
                              color: AppTheme.darkSecondaryColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: "My Wallet",
                                        fontSize: 28,
                                        FontFamily: 'amaranth',
                                        fontWeight: FontWeight.bold,
                                      ),
                                      CustomText(
                                        text:
                                            "Manage your funds and transactions",
                                        fontSize: 15,
                                        FontFamily: 'roboto',
                                        fontWeight: FontWeight.w500,
                                        color: AppTheme.darkTextLightColor,
                                      ),
                                      SizedBox(
                                        height: height * 0.035,
                                      ),
                                      CustomText(
                                        text: "₹${walletData.balance}",
                                        fontSize: 35,
                                        FontFamily: 'roboto',
                                        fontWeight: FontWeight.bold,
                                      ),
                                      CustomText(
                                        text: "Available Balance",
                                        fontSize: 15,
                                        FontFamily: 'roboto',
                                        fontWeight: FontWeight.w500,
                                        color: AppTheme.darkTextLightColor,
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.account_balance,
                                    size: 28,
                                    color: AppTheme.darkTextColorSecondary,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: height * 0.01),
                        Container(
                          width: double.infinity,
                          height: height * 0.20,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: AppTheme.darkSecondaryColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "Quick Status",
                                fontSize: 27,
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: "Total Deposits",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: AppTheme.darkTextLightColor,
                                  ),
                                  CustomText(
                                    text: "₹0",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.darkTextColorSecondary,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: height * 0.003,
                              ),
                              Divider(
                                color: AppTheme.darkBorderColor,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: "Total Withdrawals",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: AppTheme.darkTextLightColor,
                                  ),
                                  CustomText(
                                    text: "₹${walletData.balance}",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.darkTextColorSecondary,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: height * 0.003,
                              ),
                              Divider(
                                color: AppTheme.darkBorderColor,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: "Pending Transactions",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: AppTheme.darkTextLightColor,
                                  ),
                                  CustomText(
                                    text: paymentList.length.toString(),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.darkTextColorSecondary,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        CustomText(
                          text: "Transaction History",
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        paymentList.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: height * 0.050,
                                    ),
                                    LottieBuilder.asset(
                                      "assets/lottie/nodata.json",
                                      height: height * 0.20,
                                    ),
                                    CustomText(
                                      text: "No Purchase Bookings Found",
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.darkTextLightColor,
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                itemCount: paymentList.length,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final payment = paymentList[index];
                                  final createdAt = DateTime.parse(payment
                                      .createdAt!); // convert string to DateTime
                                  final formattedDate =
                                      DateFormat('dd MMM yyyy')
                                          .format(createdAt);
                                  return Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Container(
                                      width: double.infinity,
                                      height: height * 0.090,
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: AppTheme.darkSecondaryColor,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CircleAvatar(
                                            radius: width * 0.070,
                                            backgroundColor:
                                                AppTheme.appbarColorDark,
                                            child: Center(
                                              child: Icon(
                                                Icons.swap_horiz_outlined,
                                                color: AppTheme
                                                    .darkTextColorSecondary,
                                                size: 30,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: width * 0.73,
                                            // color: Colors.teal,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    CustomText(
                                                      text: payment.purpose!,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    SizedBox(
                                                      height: height * 0.01,
                                                    ),
                                                    CustomText(
                                                      text: formattedDate,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    )
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    CustomText(
                                                      text: "Pending",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    SizedBox(
                                                      height: height * 0.01,
                                                    ),
                                                    CustomText(
                                                      text:
                                                          "₹${payment.amount}",
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                      ],
                    );
                  }
                  return SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
