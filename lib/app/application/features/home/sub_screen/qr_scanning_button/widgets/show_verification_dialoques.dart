import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:zyra_momments_app/application/features/dashboard/dashboard_screen.dart';
import 'package:zyra_momments_app/application/features/dashboard/navigation/bloc/navigation_bloc.dart';
import 'package:zyra_momments_app/application/features/dashboard/navigation/bloc/navigation_tab.dart';

void showVerificationDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        backgroundColor: const Color(0xFF1A1A1A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Check icon in green circle
              LottieBuilder.asset(
                "assets/lottie/success.json",
                height: 150,
              ),

              // Title
              const Text(
                "Verification Successful",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              // Description text
              const Text.rich(
                TextSpan(
                  text: "The ",
                  children: [
                    TextSpan(
                      text: "user",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: " is verified\nand allowed to enter the "),
                    TextSpan(
                      text: "Event.",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 24),

              // Green loading dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: AnimatedDot(index: index),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Close button
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: (){
                      Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => DashBoardScreen()),
                  (route) => false,
                );
                context
                    .read<NavigationBloc>()
                    .add(NavigationTabChanged(NavigationTab.home));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text("Close"),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class AnimatedDot extends StatefulWidget {
  final int index;
  const AnimatedDot({super.key, required this.index});

  @override
  State<AnimatedDot> createState() => _AnimatedDotState();
}

class _AnimatedDotState extends State<AnimatedDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late int delay;

  @override
  void initState() {
    super.initState();
    delay = widget.index * 300;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();

    _animation = Tween(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity:
          DelayTween(delay: Duration(milliseconds: delay)).animate(_animation),
      child: Container(
        width: 10,
        height: 10,
        decoration: const BoxDecoration(
          color: Color(0xFF28A745),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class DelayTween extends Tween<double> {
  final Duration delay;

  DelayTween({required this.delay}) : super(begin: 0.0, end: 1.0);

  @override
  double lerp(double t) {
    final delayedT = (t - delay.inMilliseconds / 1000).clamp(0.0, 1.0);
    return super.lerp(delayedT);
  }

  @override
  double evaluate(Animation<double> animation) => lerp(animation.value);
}
