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
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Foodify',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 40),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(),
            child: Lottie.asset(
              'assets/lottie/4762-food-carousel.json',
              fit: BoxFit.fill,
              // animate: true,
              // 'assets/lottie/splash_screen.json',

              // controller: _controller,
              // onLoaded: (composition) {
              //   // Configure the AnimationController with the duration of the
              //   // Lottie file and start the animation.
              //   _controller!.duration = composition.duration;
              //   _controller!.forward();
              // },
            ),
          ),
        ],
      ),
    );
  }
}
