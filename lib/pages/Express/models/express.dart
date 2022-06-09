import 'package:flutter/material.dart';

class Express extends StatefulWidget {
  const Express({Key? key}) : super(key: key);

  @override
  _ExpressState createState() => _ExpressState();
}

class _ExpressState extends State<Express> {
  @override
  Widget build(BuildContext context) {
    return const Text(
      'Express',
      style: TextStyle(
        fontSize: 20,
      ),
    );
  }
}
