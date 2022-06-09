import 'package:flutter/material.dart';

class LoadingPlate extends StatefulWidget {
  const LoadingPlate({Key? key}) : super(key: key);

  @override
  _LoadingPlateState createState() => _LoadingPlateState();
}

class _LoadingPlateState extends State<LoadingPlate>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  dispose() {
    _controller.dispose();
    // you need this
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RotationTransition(
        turns: _animation,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/images/loadingplate.png',
            scale: 0.01,
          ),
        ),
      ),
    );
  }
}
