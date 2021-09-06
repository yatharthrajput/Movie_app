import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie_app/bloc/moviedetailsbloc/bloc.dart';
import 'package:the_movie_app/commonwidgets/app_error_view.dart';
import 'package:the_movie_app/commonwidgets/genre_line.dart';
import 'package:the_movie_app/commonwidgets/loader.dart';
import 'package:the_movie_app/commonwidgets/actor_scroller.dart';
import 'package:the_movie_app/commonwidgets/detail_page_header.dart';
import 'package:the_movie_app/commonwidgets/photo_scroller.dart';
import 'package:the_movie_app/commonwidgets/story_line.dart';

class MovieDetails extends StatefulWidget {
  MovieDetails({this.id});

  final String id;

  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  MovieDetailsBloc _movieDetailsBloc;

  @override
  void initState() {
    _movieDetailsBloc = BlocProvider.of<MovieDetailsBloc>(context);
    _movieDetailsBloc.dispatch(FetchMovieDetails(id: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _movieDetailsBloc,
      builder: (BuildContext context, MovieDetailsState state) {
        if (state is InitialMovieDetailsState) {
          return Loader();
        }

        if (state is ErrorMovieDetailsState) {
          return ApiErrorView(
            message: "Some error occurred while loading details",
            onTap: () =>
                _movieDetailsBloc.dispatch(FetchMovieDetails(id: widget.id)),
          );
        }

        if (state is LoadedMovieDetailsState) {
          return SingleChildScrollView(
            child: Column(
              children: [
                DetailsPageHeader(
                  state.detailsResponse.title,
                  state.detailsResponse.backdropPath,
                  state.detailsResponse.posterPath,
                  averageRating: state.detailsResponse.voteAverage,
                ),
                SizedBox(height: 20.0),
                GenreLine(
                  genres: state.detailsResponse.genres,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: StoryLine(state.detailsResponse.overview),
                ),
                SizedBox(height: 20.0),
                PhotoScroller(
                  images: state.images,
                ),
                SizedBox(height: 20.0),
                ActorScroller(
                    casts: state.casts,
                    onTap: (int id) =>
                        Navigator.pushNamed(context, "/celebdetails/$id")),
                SizedBox(height: 50.0),
              ],
            ),
          );
        }
      },
    );
  }
}
