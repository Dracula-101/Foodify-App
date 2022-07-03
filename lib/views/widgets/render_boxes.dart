import 'package:flutter/material.dart';

class BndBox extends StatelessWidget {
  final List<dynamic> results;
  final int previewH;
  final int previewW;
  final double screenH;
  final double screenW;

  const BndBox(
      this.results, this.previewH, this.previewW, this.screenH, this.screenW,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _renderStrings() {
      double offset = -10;
      return results.map((re) {
        offset = offset + 14;
        return Positioned(
          left: 10,
          top: offset,
          width: screenW,
          height: screenH,
          child: Text(
            "${re["label"]} ${(re["confidence"] * 100).toStringAsFixed(0)}%",
            style: const TextStyle(
              color: Colors.amberAccent,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }).toList();
    }

    return Stack(
      children: _renderStrings(),
    );
  }
}
