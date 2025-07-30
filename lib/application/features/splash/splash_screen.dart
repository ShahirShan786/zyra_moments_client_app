import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'dart:developer';
import 'package:zyra_momments_app/application/features/auth/auth_screen.dart';
import 'package:zyra_momments_app/application/features/dashboard/dashboard_screen.dart';
import 'package:zyra_momments_app/application/features/splash/bloc/splash_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;
  bool _isVideoInitialized = false;
  bool _navigationTriggered = false;
  final SplashBloc _splashBloc = SplashBloc();

  @override
  void initState() {
    super.initState();
    log("SplashScreen initState called");
    _controller = VideoPlayerController.asset("assets/splash/splash.mp4")
      ..initialize().then((_) {
        setState(() {
          _isVideoInitialized = true;
          _controller.setLooping(true);
          _controller.play();
        });

        log("Video initialized, starting navigation timer");

        // Check auth status after minimum splash duration
        Future.delayed(const Duration(seconds: 5), () {
          log("Navigation timer completed, checking auth status");
          if (!_navigationTriggered) {
            log("Triggering CheckLoginStatusEvent");
            _splashBloc.add(CheckLoginStatusEvent());
          }
        });
      });
  }

  @override
  void dispose() {
    log("SplashScreen dispose called");
    _controller.pause();
    _controller.dispose();
    _splashBloc.close();
    super.dispose();
  }

  void _navigateToNextScreen(BuildContext context, Widget screen) {
    log("_navigateToNextScreen called with ${screen.runtimeType}");
    if (!_navigationTriggered) {
      setState(() {
        _navigationTriggered = true;
      });

      log("Navigation triggered, stopping video");
      // Stop video before navigating
      _controller.pause();

      log("Navigating to ${screen.runtimeType}");
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => screen),
      );
    } else {
      log("Navigation already triggered, ignoring");
    }
  }

  // Force navigation after maximum wait time (failsafe)
  void _startFailsafeTimer() {
    Future.delayed(const Duration(seconds: 10), () {
      log("Failsafe timer triggered");
      if (!_navigationTriggered) {
        log("Navigating to AuthScreen via failsafe");
        _navigateToNextScreen(context, AuthScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    log("SplashScreen build called");
    var height = MediaQuery.of(context).size.height;

    // Start failsafe timer on first build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_navigationTriggered) {
        _startFailsafeTimer();
      }
    });

    return BlocProvider(
      create: (context) => _splashBloc,
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          log("BlocListener received state: $state");
          if (state is SplashAuthenticated) {
            log("Authenticated state received");
            _navigateToNextScreen(context, DashBoardScreen());
          } else if (state is SplashUnAuthenticated) {
            log("Unauthenticated state received");
            _navigateToNextScreen(context, AuthScreen());
          }
        },
        child: Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              // Background video
              if (_isVideoInitialized)
                FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _controller.value.size.width,
                    height: _controller.value.size.height,
                    child: VideoPlayer(_controller),
                  ),
                ),

              // Overlay content (logo + title)
              Container(
                color: Colors.black.withAlpha(450), // dim the video
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Replace with your logo
                      Image.asset(
                        'assets/logo/ZyraLogo.png',
                        height: height * 0.45,
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0.0, 0.24),
                child: DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      ColorizeAnimatedText(
                        'ZYRA MOMENTS',
                        textStyle: const TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.w900,
                        ),
                        colors: [
                          Colors.white,
                          Color(0xFF444444), // dark grey
                          Color(0xFF8A2BE2), // blue violet
                          Color(0xFF4B0082), // indigo
                          Colors.white,
                        ],
                        speed: Duration(milliseconds: 500),
                      ),
                    ],
                    isRepeatingAnimation: true,
                    repeatForever: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:video_player/video_player.dart';
// import 'package:zyra_momments_app/application/features/auth/auth_screen.dart';
// import 'package:zyra_momments_app/application/features/dashboard/dashboard_screen.dart';
// import 'package:zyra_momments_app/application/features/splash/bloc/splash_bloc.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   late VideoPlayerController _controller;
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.asset("assets/splash/splash.mp4")
//       ..initialize().then((_) {
//         setState(() {
//           _controller.setLooping(true);
//           _controller.play();
//         });
//         Future.delayed(const Duration(seconds: 8), () {
//           // Stop audio and video before navigating
//           _controller.pause();
//           _controller.seekTo(Duration.zero); // Rewind the video to the start
//           Navigator.of(context).pushReplacement(MaterialPageRoute(
//             builder: (context) => AuthScreen(),
//           ));
//         });
//       });
//   }

//   @override
//   void dispose() {
//     // Dispose the video controller properly
//     _controller.pause(); // Stop the video
//     _controller.dispose(); // Properly dispose the video controller
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     return BlocProvider(
//       create: (context) => SplashBloc()..add(CheckLoginStatusEvent()),
//       child: BlocListener<SplashBloc, SplashState>(
//         listener: (context, state) {
//           if (state is SplashAuthenticated) {
//             Navigator.of(context).push(MaterialPageRoute(
//               builder: (context) => DashBoardScreen(),
//             ));
//           } else if (state is SplashUnAuthenticated) {
//             Navigator.of(context).push(MaterialPageRoute(
//               builder: (context) => AuthScreen(),
//             ));
//           }
//         },
//         child: Scaffold(
//           body: Stack(
//             fit: StackFit.expand,
//             children: [
//               // Background video
//               if (_controller.value.isInitialized)
//                 FittedBox(
//                   fit: BoxFit.cover,
//                   child: SizedBox(
//                     width: _controller.value.size.width,
//                     height: _controller.value.size.height,
//                     child: VideoPlayer(_controller),
//                   ),
//                 ),

//               // Overlay content (logo + title)
//               Container(
//                 color: Colors.black.withAlpha(450), // dim the video
//                 child: Center(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       // Replace with your logo
//                       Image.asset(
//                         'assets/logo/ZyraLogo.png',
//                         height: height * 0.45,
//                       ),
//                       SizedBox(height: 20),
//                     ],
//                   ),
//                 ),
//               ),
//               Align(
//                 alignment: Alignment(0.0, 0.24),
//                 child: DefaultTextStyle(
//                   style: const TextStyle(
//                     fontSize: 32.0,
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 2,
//                   ),
//                   child: AnimatedTextKit(
//                     animatedTexts: [
//                       ColorizeAnimatedText(
//                         'ZYRA MOMENTS',
//                         textStyle: const TextStyle(
//                           fontSize: 40.0,
//                           fontWeight: FontWeight.w900,
//                         ),
//                         colors: [
//                           Colors.white,
//                           Color(0xFF444444), // dark grey
//                           Color(0xFF8A2BE2), // blue violet
//                           Color(0xFF4B0082), // indigo
//                           Colors.white, // Bright Yellow
//                         ],
//                         speed: Duration(milliseconds: 500),
//                       ),
//                     ],
//                     isRepeatingAnimation:
//                         true, // or false if you want it only once
//                     repeatForever: true,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Route _createFadeRoute(Widget page) {
//     return PageRouteBuilder(
//       pageBuilder: (context, animation, secondaryAnimation) => page,
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         return FadeTransition(
//           opacity: animation,
//           child: child,
//         );
//       },
//       transitionDuration:
//           const Duration(milliseconds: 800), // Customize transition time
//     );
//   }
// }
