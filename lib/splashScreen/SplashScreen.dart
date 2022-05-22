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
  AnimationController? _textAnimation;
  late Animation<double> _animation;
  double _opacity = 1;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    _textAnimation = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _textAnimation!,
      curve: Curves.bounceIn,
    );
    fadeText();
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    _textAnimation!.dispose();
    super.dispose();
  }

  fadeText() async {
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() {
        _opacity = 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Stack(
            children: [
              Lottie.asset(
                'assets/videos/splash_animation.json',
                controller: _controller,
                onLoaded: (composition) {
                  _controller!.duration = composition.duration;
                  _controller!.forward();
                },
              ),
              Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.67),
                  AnimatedOpacity(
                    opacity: _opacity,
                    duration: const Duration(seconds: 1),
                    child: const Center(
                      child: Text(
                        'Foodify',
                        style: TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
