import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodify/views/widgets/shimmer_widget.dart';
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
  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: MediaQuery.of(context).size.width,
      height: 180,
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: widget.thumbnail,
            imageBuilder: (context, imageProvider) => Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            placeholder: (context, url) => ShimmerWidget.rectangular(
                height: 180, br: BorderRadius.circular(15)),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          Align(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                widget.title,
                style: const TextStyle(fontSize: 19, color: Colors.white),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
            alignment: Alignment.center,
          ),
          Align(
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.grey.shade200.withOpacity(0.9)),
              child: Text(
                widget.title,
                style: const TextStyle(fontSize: 23, color: Colors.black),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
            alignment: Alignment.center,
          ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
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
    ));
  }
}
