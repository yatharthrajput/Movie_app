import 'package:flutter/material.dart';
import 'package:the_movie_app/utils/url_provider.dart';
import 'package:transparent_image/transparent_image.dart';

class Poster extends StatelessWidget {
  static const POSTER_RATIO = 0.7;

  Poster(
    this.posterUrl, {
    this.height = 100.0,
  });

  final String posterUrl;
  final double height;

  @override
  Widget build(BuildContext context) {
    var width = POSTER_RATIO * height;

    return Material(
      borderRadius: BorderRadius.circular(4.0),
      elevation: 2.0,
      child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: posterUrl != null
            ? "$IMAGE_BASE_URL$posterUrl"
            : "$PLACEHOLDER_URL_500",
        fit: BoxFit.cover,
        width: width,
        height: height,
      ),
    );
  }
}
