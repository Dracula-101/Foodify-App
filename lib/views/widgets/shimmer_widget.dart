import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double height;
  final double width;
  final BorderRadius br;

  const ShimmerWidget.rectangular({
    Key? key,
    required this.height,
    this.width = double.infinity,
    required this.br,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: Colors.grey[500]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          // margin: EdgeInsets.all(10),
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.grey[400]!,
            borderRadius: br,
          ),
        ),
      );
}
