







// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import 'package:zyra_momments_app/application/config/theme.dart';
// import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

// Widget buildHeroSection(BuildContext context) {
//   final width = MediaQuery.of(context).size.width;
//   final height = MediaQuery.of(context).size.width; // Keep your original logic

//   return Container(
//     width: double.infinity,
//     height: height * 0.65, // Keep your original height
//     decoration:
//         BoxDecoration(color: Colors.grey[800]), // Keep your original background
//     child: Stack(
//       children: [
//         _buildImageCarousel(height),
//         // Keep your exact original text positioning
//         Positioned(
//           top: height * 0.1,
//           left: 10,
//           child: CustomText(
//             text: "Elevate your Events with\nEventPro",
//             fontSize: 30,
//             fontWeight: FontWeight.bold,
//             FontFamily: 'amaranth',
//             color: AppTheme.darkTextColorPrymary,
//           ),
//         ),
//         Positioned(
//           top: height * 0.3,
//           left: 10,
//           child: SizedBox(
//             width: width * 0.9,
//             child: CustomText(
//               maxLines: 4,
//               overflow: TextOverflow.ellipsis,
//               text:
//                   "Streamline your event management process and create unforgettable experiences with our cutting-edge platform.",
//               fontSize: 16,
//               fontWeight: FontWeight.w500,
//               FontFamily: 'amaranth',
//               color: AppTheme.darkTextColorPrymary,
//             ),
//           ),
//         ),
//         Positioned(
//           bottom: 10,
//           left: 10,
//           child: _buildHeroButtons(width, height),
//         ),
//       ],
//     ),
//   );
// }

// class _HeroCarousel extends StatefulWidget {
//   final double height;

//   const _HeroCarousel({required this.height});

//   @override
//   _HeroCarouselState createState() => _HeroCarouselState();
// }

// class _HeroCarouselState extends State<_HeroCarousel> {
//   final PageController _pageController = PageController();
//   Timer? _timer;
//   int _currentIndex = 0;
//   bool _disposed = false;

//   final List<String> imagePaths = [
//     'assets/images/dashboard1.jpg',
//     'assets/images/dashboard2.jpg',
//     'assets/images/dashboard3.jpg',
//     'assets/images/dashboard4.jpg',
//     'assets/images/dashboard5.jpg',
   
//   ];

//   @override
//   void initState() {
//     super.initState();
//     // Start auto-play after widget is built
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (!_disposed) {
//         _startAutoPlay();
//       }
//     });
//   }

//   void _startAutoPlay() {
//     _timer?.cancel();
//     if (!_disposed && mounted) {
//       _timer = Timer.periodic(Duration(seconds: 5), (timer) {
//         if (!_disposed && mounted && _pageController.hasClients) {
//           final nextIndex = (_currentIndex + 1) % imagePaths.length;
//           _pageController.animateToPage(
//             nextIndex,
//             duration: Duration(milliseconds: 800),
//             curve: Curves.fastOutSlowIn,
//           );
//         }
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _disposed = true;
//     _timer?.cancel();
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         // PageView carousel
//         SizedBox(
//           height: widget.height * 0.65,
//           child: PageView.builder(
//             controller: _pageController,
//             itemCount: imagePaths.length,
//             onPageChanged: (index) {
//               if (!_disposed && mounted) {
//                 setState(() {
//                   _currentIndex = index;
//                 });
//               }
//             },
//             itemBuilder: (context, index) {
//               return Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage(imagePaths[index]),
//                     fit: BoxFit.cover,
//                     onError: (exception, stackTrace) {
//                       print('Error loading image: ${imagePaths[index]}');
//                     },
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//         // Page indicators positioned at the bottom
//         Positioned(
//           bottom: 5,
//           left: 0,
//           right: 0,
//           child: Center(
//             child: SmoothPageIndicator(
//               controller: _pageController,
//               count: imagePaths.length,
//               effect: WormEffect(
//                 dotColor: Colors.white.withOpacity(0.5),
//                 activeDotColor: AppTheme.darkButtonPrimaryColor,
//                 dotHeight: 6,
//                 dotWidth: 6,
//                 spacing: 8,
//                 radius: 3,
//                 paintStyle: PaintingStyle.fill,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// Widget _buildImageCarousel(double height) {
//   return _HeroCarousel(height: height);
// }

// Widget _buildHeroButtons(double width, double height) {
//   return Row(
//     children: [
//       _buildHeroButton(
//         width: width * 0.38,
//         height: height * 0.10,
//         text: "Start Free Trial",
//         backgroundColor: AppTheme.darkButtonPrimaryColor,
//         textColor: AppTheme.darkPrimaryColor,
//       ),
//       SizedBox(width: width * 0.03),
//       _buildHeroButton(
//         width: width * 0.34,
//         height: height * 0.10,
//         text: "Watch Demo",
//         backgroundColor: AppTheme.darkPrimaryColor,
//         textColor: AppTheme.darkButtonPrimaryColor,
//         border: Border.all(
//           color: AppTheme.darkTextColorPrymary,
//           width: 1,
//         ),
//       ),
//     ],
//   );
// }

// Widget _buildHeroButton({
//   required double width,
//   required double height,
//   required String text,
//   required Color backgroundColor,
//   required Color textColor,
//   Border? border,
// }) {
//   return Container(
//     width: width,
//     height: height,
//     alignment: Alignment.center,
//     decoration: BoxDecoration(
//       color: backgroundColor,
//       borderRadius: BorderRadius.circular(5),
//       border: border,
//     ),
//     child: CustomText(
//       text: text,
//       fontSize: 15,
//       color: textColor,
//       fontWeight: FontWeight.w600,
//     ),
//   );
// }










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
  final List<String> imagePaths = [
    'assets/images/dashboard1.jpg',
    'assets/images/dashboard2.jpg',
    'assets/images/dashboard3.jpg',
    'assets/images/dashboard4.jpg',
    'assets/images/dashboard5.jpg',
  ];

  return CarouselSlider.builder(
    itemCount: imagePaths.length,
    itemBuilder: (context, index, realIdx) {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePaths[index]),
            fit: BoxFit.cover,
          ),
        ),
      );
    },
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


  // Widget _buildImageCarousel(double height) {
  //   return CarouselSlider(
  //     items: [
  //       'assets/images/dashboard1.jpg',
  //       'assets/images/dashboard2.jpg',
  //       'assets/images/dashboard3.jpg',
  //       'assets/images/dashboard4.jpg',
  //       'assets/images/dashboard5.jpg',
  //     ].map((imagePath) {
  //       return Container(
  //         width: double.infinity,
  //         decoration: BoxDecoration(
  //           image: DecorationImage(
  //             image: AssetImage(imagePath),
  //             fit: BoxFit.cover,
  //           ),
  //         ),
  //       );
  //     }).toList(),
  //     options: CarouselOptions(
  //       height: height * 0.65,
  //       viewportFraction: 1.0,
  //       autoPlay: true,
  //       autoPlayInterval: Duration(seconds: 5),
  //       autoPlayAnimationDuration: Duration(milliseconds: 800),
  //       autoPlayCurve: Curves.fastOutSlowIn,
  //     ),
  //   );
  // }

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