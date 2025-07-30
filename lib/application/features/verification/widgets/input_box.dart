import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zyra_momments_app/application/config/theme.dart';


class inputBox extends StatelessWidget {
  const inputBox({
    super.key,
    required this.height,
    required this.width, required this.controller,
  });
  final TextEditingController controller;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.070,
      width: width * 0.14,
      decoration: BoxDecoration(
          border: Border.all(color: AppTheme.darkBorderColor),
          color: AppTheme.darkPrimaryColor,
          borderRadius: BorderRadius.circular(8)),
      child: TextFormField(
        controller:  controller,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: AppTheme.darkTextColorSecondary),
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        decoration: InputDecoration(border: InputBorder.none),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}
