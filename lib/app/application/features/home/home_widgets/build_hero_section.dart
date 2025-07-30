  import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

Widget buildHeroSection(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      height: height * 0.65,
      decoration: BoxDecoration(color: Colors.grey[800]),
      child: Stack(
        children: [
          _buildImageCarousel(height),
          Positioned(
            top: height * 0.1,
            left: 10,
            child: CustomText(
              text: "Elevate your Events with\nEventPro",
              fontSize: 30,
              fontWeight: FontWeight.bold,
              FontFamily: 'amaranth',
              color: AppTheme.darkTextColorPrymary,
            ),
          ),
          Positioned(
            top: height * 0.3,
            left: 10,
            child: SizedBox(
              width: width * 0.9,
              child: CustomText(
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                text:
                    "Streamline your event management process and create unforgettable experiences with our cutting-edge platform.",
                fontSize: 16,
                fontWeight: FontWeight.w500,
                FontFamily: 'amaranth',
                color: AppTheme.darkTextColorPrymary,
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: _buildHeroButtons(width, height),
          ),
        ],
      ),
    );
  }

  Widget _buildImageCarousel(double height) {
    return CarouselSlider(
      items: [
        'assets/images/dashboard1.jpg',
        'assets/images/dashboard2.jpg',
        'assets/images/dashboard3.jpg',
        'assets/images/dashboard4.jpg',
        'assets/images/dashboard5.jpg',
      ].map((imagePath) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        );
      }).toList(),
      options: CarouselOptions(
        height: height * 0.65,
        viewportFraction: 1.0,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 5),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
      ),
    );
  }

  Widget _buildHeroButtons(double width, double height) {
    return Row(
      children: [
        _buildHeroButton(
          width: width * 0.38,
          height: height * 0.10,
          text: "Start Free Trial",
          backgroundColor: AppTheme.darkButtonPrimaryColor,
          textColor: AppTheme.darkPrimaryColor,
        ),
        SizedBox(width: width * 0.03),
        _buildHeroButton(
          width: width * 0.34,
          height: height * 0.10,
          text: "Watch Demo",
          backgroundColor: AppTheme.darkPrimaryColor,
          textColor: AppTheme.darkButtonPrimaryColor,
          border: Border.all(
            color: AppTheme.darkTextColorPrymary,
            width: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildHeroButton({
    required double width,
    required double height,
    required String text,
    required Color backgroundColor,
    required Color textColor,
    Border? border,
  }) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(5),
        border: border,
      ),
      child: CustomText(
        text: text,
        fontSize: 15,
        color: textColor,
        fontWeight: FontWeight.w600,
      ),
    );
  }