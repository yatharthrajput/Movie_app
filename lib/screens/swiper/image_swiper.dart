import 'package:flutter/material.dart';
import 'package:the_movie_app/models/common/images.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:the_movie_app/utils/constants.dart';
import 'package:the_movie_app/utils/url_provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ImageSwiper extends StatelessWidget {
  ImageSwiper({this.list, this.pos = 0});

  final List<Images> list;
  final int pos;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var brightness = theme.brightness;
    return Scaffold(
      body: Center(
        child: Swiper(
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            Images image = list[index];
            return Center(
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                fadeInDuration: Duration(microseconds: 100),
                image: "$IMAGE_BASE_URL${image.filePath}",
                fit: BoxFit.cover,
              ),
            );
          },
          index: pos,
          controller: SwiperController(),
          control: SwiperControl(color: brightness == Brightness.dark ? Colors.white : theme.primaryColor),
        ),
      ),
    );
  }
}
