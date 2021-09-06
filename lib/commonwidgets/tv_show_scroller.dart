import 'package:flutter/material.dart';
import 'package:the_movie_app/commonwidgets/movie_view.dart';
import 'package:the_movie_app/models/tv/tv_show_model.dart';
import 'package:the_movie_app/utils/constants.dart';
import 'package:the_movie_app/utils/url_provider.dart';

class TvShowScroller extends StatelessWidget {
  TvShowScroller({this.tvShows});

  final List<TvShowModel> tvShows;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Text(
            'Tv Shows',
            style: TextStyle(
              color: Constants.textColor(theme.brightness),
              fontWeight: FontWeight.w500,
              fontSize: 18.0,
            ),
          ),
        ),
        SizedBox.fromSize(
          size: const Size.fromHeight(250.0),
          child: ListView.builder(
            itemCount: tvShows.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(top: 8.0, left: 20.0),
            itemBuilder: (BuildContext context, int index) => MovieView(
                  id: tvShows[index].id,
                  title: tvShows[index].name,
                  posterPath: tvShows[index].posterPath != null
                      ? "$IMAGE_BASE_URL${tvShows[index].posterPath}"
                      : "$PLACEHOLDER_URL_150",
                  onTap: (int id) =>
                      Navigator.pushNamed(context, "/tvdetails/$id"),
                ),
          ),
        ),
      ],
    );
  }
}
