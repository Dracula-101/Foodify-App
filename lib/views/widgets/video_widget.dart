import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodify/views/widgets/shimmer_widget.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  final String title, length, thumbnail, youtubeId, views;
  VideoWidget(
      {required this.title,
      required this.length,
      required this.thumbnail,
      required this.youtubeId,
      required this.views});
  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  double _sigmaX = 0.0; // from 0-10
  double _sigmaY = 0.0; // from 0-10
  double _opacity = 0.1; // from 0-1.0
  double _width = 350;
  double _height = 300;

  Widget buildGradient() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.6, 0.95],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleAndSubtitle() {
    return Positioned(
      left: 15,
      right: 15,
      bottom: 20,
      child: Text(
        widget.title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 17,
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: openVideoURL,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
        width: MediaQuery.of(context).size.width,
        height: 180,
        child: Stack(
          children: [
            CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: widget.thumbnail,
              imageBuilder: (context, imageProvider) => Align(
                alignment: Alignment.center,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                    color: Colors.amber,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.6),
                        offset: const Offset(
                          0.0,
                          10.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: -6.0,
                      ),
                    ],
                  ),
                ),
              ),
              placeholder: (context, url) => ShimmerWidget.rectangular(
                  height: 180, br: BorderRadius.circular(15)),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            buildGradient(),
            _buildTitleAndSubtitle()
          ],
        ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.6),
              offset: const Offset(
                0.0,
                10.0,
              ),
              blurRadius: 10.0,
              spreadRadius: -6.0,
            ),
          ],
          // image: DecorationImage(
          //   colorFilter: ColorFilter.mode(
          //     Colors.black.withOpacity(0.5),
          //     BlendMode.multiply,
          //   ),
          //   image: NetworkImage(thumbnailUrl),
          //   fit: BoxFit.cover,
          // ),
        ),
      ),
    );
  }

  openVideoURL() async {
    String URL = 'https://www.youtube.com/watch?v=' + widget.youtubeId;

    await launch(URL, forceWebView: false, enableJavaScript: true);
  }
}
