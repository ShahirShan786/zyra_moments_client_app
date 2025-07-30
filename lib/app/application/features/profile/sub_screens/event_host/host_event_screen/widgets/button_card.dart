import 'package:flutter/material.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

class Button_Card extends StatelessWidget {
  const Button_Card({
    super.key,
    required this.height,
    required this.width,
    required this.title,
    required this.content,
    required this.leadingIcon, required this.buttonColors, required this.onTap,

  });

  final double height;
  final double width;
  final String title;
  final String content;
  final IconData leadingIcon;
  final List<Color> buttonColors;
  final VoidCallback? onTap;
  // final Color leadingColor;
  // final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: height * 0.14,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: buttonColors,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: width * 0.11,
                height: height * 0.065,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 114, 158, 233),
                    borderRadius: BorderRadius.circular(10)),
                child: Icon(
                  leadingIcon,
                  size: 30,
                  color: AppTheme.darkTextColorSecondary,
                ),
              ),
              // SizedBox(
              //   width: width * 0.01,
              // ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: title,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                  CustomText(
                    text: content,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  )
                ],
              ),
              SizedBox(
                width: width * 0.001,
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppTheme.darkTextColorSecondary,
              )
            ],
          ),
        ),
      ),
    );
  }
}
