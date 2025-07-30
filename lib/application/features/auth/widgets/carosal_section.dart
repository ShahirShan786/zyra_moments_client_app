import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:zyra_momments_app/application/config/dashboard_images.dart';

class CarosalSection extends StatelessWidget {
  const CarosalSection({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: height * 0.32,
          child: CarouselSlider(
            items: images,
            options: CarouselOptions(
                height: height * 0.5,
                aspectRatio: 16 / 9,
                viewportFraction: 1.0,
                autoPlayInterval: Duration(seconds: 10),
                autoPlayAnimationDuration: Duration(milliseconds: 1000),
                autoPlayCurve: Curves.easeInOut,
                autoPlay: true),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            width: double.infinity,
            height: height * 0.7,
            color: Colors.black.withAlpha(100),
          ),
        ),
        Positioned(
          top: height * 0.13,
          left: width * 0.25,
          child: Text(
            "Welcome back",
            style: TextStyle(
                fontSize: 32,
                fontFamily: "amaranth",
                fontWeight: FontWeight.w800,
                color: Colors.white),
          ),
        ),
        Positioned(
          top: height * 0.18,
          left: width * 0.17,
          child: Text(
            "we’re glad to  see you again!",
            style: TextStyle(
                fontSize: 22,
                fontFamily: 'open',
                fontWeight: FontWeight.w400,
                color: Colors.white),
          ),
        )
      ],
    );
  }
}