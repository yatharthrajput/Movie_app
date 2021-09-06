import 'package:flutter/material.dart';
import 'package:the_movie_app/utils/constants.dart';
import 'package:transparent_image/transparent_image.dart';

class MovieView extends StatelessWidget {
  MovieView({this.id, this.title, this.posterPath, this.onTap});

  final int id;
  final String title;
  final String posterPath;
  final void Function(int) onTap;

  final double height = 160.0;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 0, right: 16),
      child: GestureDetector(
        onTap: () => this.onTap(id),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: Material(
                elevation: 2.0,
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: posterPath,
                  fit: BoxFit.cover,
                  width: 0.7 * height,
                  height: height,
                ),
              ),
            ),
            Container(
              width: 0.7 * height,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                title,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Constants.textColor(theme.brightness),
                  fontSize: 15.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
