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
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          // const Text(
          //   'Foodify',
          //   style: TextStyle(
          //     fontSize: 25,
          //     fontWeight: FontWeight.bold,
          //     color: Colors.amber,
          //   ),
          // ),
          Lottie.asset(
            'assets/lottie/4762-food-carousel.json',
            width: 250,
            controller: _controller,
            onLoaded: (composition) {
              _controller!.duration = composition.duration;
              _controller!.forward();
            },
          ),
        ],
      ),
    );
  }
}
