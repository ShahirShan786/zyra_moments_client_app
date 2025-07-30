import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:zyra_momments_app/app/application/features/profile/sub_screens/transaction/transaction_bloc/bloc/transaction_bloc.dart';
import 'package:zyra_momments_app/application/config/theme.dart';

import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => TransactionBloc()..add(GetAllTransactionRequest()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: CustomText(
            text: "My Wallet",
            fontSize: 25,
            FontFamily: 'roboto',
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Transaction History",
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
              BlocBuilder<TransactionBloc, TransactionState>(
                builder: (context, state) {
                  if (state is GetTransactionLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is GetTransactionFailureState) {
                    return Center(
                      child: CustomText(text: state.errorMessage),
                    );
                  } else if (state is GetTransactionSuccessState) {
                    final paymentList = state.transactionPayment;
                    return paymentList.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: height * 0.25,
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
                              // convert string to DateTime
                              final formattedDate = DateFormat('dd MMM yyyy')
                                  .format(payment.createdAt!);
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  width: double.infinity,
                                  height: height * 0.090,
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: AppTheme.darkSecondaryColor,
                                      borderRadius: BorderRadius.circular(8)),
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
                                            color:
                                                AppTheme.darkTextColorSecondary,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.73,
                                        // color: Colors.teal,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                  text: payment.purpose!,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                SizedBox(
                                                  height: height * 0.01,
                                                ),
                                                CustomText(
                                                  text: formattedDate,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                )
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                CustomText(
                                                  text: "Pending",
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                SizedBox(
                                                  height: height * 0.01,
                                                ),
                                                CustomText(
                                                  text: "₹${payment.amount}",
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
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
                          );
                  }
                  return SizedBox();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
