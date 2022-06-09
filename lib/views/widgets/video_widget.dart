import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodify/views/widgets/shimmer_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoWidget extends StatefulWidget {
  final String title, length, thumbnail, youtubeId, views;
  const VideoWidget(
      {required this.title,
      required this.length,
      required this.thumbnail,
      required this.youtubeId,
      required this.views,
      Key? key})
      : super(key: key);
  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
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
    String url = 'https://www.youtube.com/watch?v=' + widget.youtubeId;

    await launch(url, forceWebView: false, enableJavaScript: true);
  }
}
