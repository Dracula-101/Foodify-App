import 'dart:async';
import 'package:flutter/material.dart';
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
  double _opacity = 0;
  bool changeDim = false;
  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    _textAnimation = AnimationController(
      duration: const Duration(milliseconds: 6000),
      vsync: this,
    );
    fadeInText();
    if (mounted) {
      Timer(
        const Duration(milliseconds: 2000),
        () => setState(() {
          changeDim = !changeDim;
        }),
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    _textAnimation!.dispose();
    super.dispose();
  }

  fadeInText() async {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (!mounted) return;
      setState(() {
        _opacity = 1;
      });
    });
  }

  fadeOutText() async {
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
      // backgroundColor: Colors.white,
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
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 1500),
                    curve: Curves.fastOutSlowIn,
                    height: changeDim
                        ? MediaQuery.of(context).size.height * 0.35
                        : MediaQuery.of(context).size.height * 0.7,
                  ),
                  AnimatedOpacity(
                    opacity: _opacity,
                    duration: const Duration(seconds: 2),
                    child: const Center(
                      child: FittedBox(
                        child: Text(
                          'Foodify',
                          style: TextStyle(
                            color: Colors.deepOrangeAccent,
                            fontSize: 55,
                            fontFamily: 'Amsterdam-ZVGqm',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
