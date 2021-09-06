import 'package:flutter/material.dart';
import 'package:the_movie_app/commonwidgets/arc_banner_image.dart';
import 'package:the_movie_app/commonwidgets/poster.dart';
import 'package:the_movie_app/commonwidgets/rating_information.dart';

class DetailsPageHeader extends StatelessWidget {
  DetailsPageHeader(this.title, this.backDropPath, this.posterPath,
      {this.averageRating = 0});

  final String title;
  final String backDropPath;
  final String posterPath;
  final num averageRating;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    var movieInformation = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 40.0),
        Text(
          title,
          style: textTheme.title,
        ),
        SizedBox(height: 8.0),
        RatingInformation(
          averageRating: averageRating.toString(),
        ),
        SizedBox(height: 12.0),
        //Row(children: _buildCategoryChips(textTheme)),
      ],
    );

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 130.0),
          child: ArcBannerImage(backDropPath),
        ),
        Positioned(
          bottom: 0.0,
          left: 16.0,
          right: 16.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Poster(
                posterPath,
                height: 180.0,
              ),
              SizedBox(width: 16.0),
              Expanded(child: movieInformation),
            ],
          ),
        ),
        AppBar(
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
        )
      ],
    );
  }
}
