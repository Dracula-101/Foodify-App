import 'package:flutter/material.dart';
import 'package:foodify/views/widgets/video_widget.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Foodify',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        Lottie.asset(
          'assets/lottie/4762-food-carousel.json',
          width: 280,
          controller: _controller,
          onLoaded: (composition) {
            _controller!.duration = composition.duration;
            _controller!.forward();
          },
        ),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }
}
