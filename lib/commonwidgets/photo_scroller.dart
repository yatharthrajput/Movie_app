import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:the_movie_app/models/common/images.dart';
import 'package:the_movie_app/screens/swiper/image_swiper.dart';
import 'package:the_movie_app/utils/constants.dart';
import 'package:the_movie_app/utils/url_provider.dart';
import 'package:transparent_image/transparent_image.dart';

class PhotoScroller extends StatelessWidget {
  PhotoScroller({this.images});

  final List<Images> images;

  Widget _buildPhoto(BuildContext context, int index, List<Images> movieList) {
    Images movieImage = movieList[index];
    json.encode(movieImage);

    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4.0),
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: movieImage.filePath != null
                ? "$IMAGE_BASE_URL${movieImage.filePath}"
                : "$PLACEHOLDER_URL_500",
            fit: BoxFit.cover,
            width: 170.0,
            height: 140.0,
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new ImageSwiper(
                      list: movieList,
                      pos: index,
                    )));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
          child: Text(
            'Photos',
            style: TextStyle(
              color: Constants.textColor(theme.brightness),
              fontWeight: FontWeight.w500,
              fontSize: 18.0,
            ),
          ),
        ),
        SizedBox.fromSize(
          size: const Size.fromHeight(100.0),
          child: ListView.builder(
            itemCount: images.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(top: 8.0, left: 20.0),
            itemBuilder: (BuildContext context, int index) =>
                _buildPhoto(context, index, images),
          ),
        ),
      ],
    );
  }
}
