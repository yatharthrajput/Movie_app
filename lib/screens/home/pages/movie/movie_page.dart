import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie_app/bloc/movielistbloc/movie_list_bloc.dart';
import 'package:the_movie_app/repository/repository.dart';
import 'package:the_movie_app/screens/home/pages/movie/movie_list_page.dart';
import 'package:the_movie_app/utils/constants.dart';

class MoviePage extends StatelessWidget {
  MoviePage({@required this.repository});

  final Repository repository;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        BlocProvider<MovieListBloc>(
          key: Key(Constants.NOW_PLAYING_MOVIES),
          bloc: MovieListBloc(repository),
          child: MovieListPage(
            title: "In Theaters",
            type: Constants.NOW_PLAYING_MOVIES,
          ),
        ),
        BlocProvider<MovieListBloc>(
          key: Key(Constants.POPULAR_MOVIES),
          bloc: MovieListBloc(repository),
          child: MovieListPage(
            title: "Most Popular",
            type: Constants.POPULAR_MOVIES,
          ),
        ),
        BlocProvider<MovieListBloc>(
          key: Key(Constants.TOP_RATED_MOVIES),
          bloc: MovieListBloc(repository),
          child: MovieListPage(
            title: "Top Rated",
            type: Constants.TOP_RATED_MOVIES,
          ),
        ),
        BlocProvider<MovieListBloc>(
          key: Key(Constants.UPCOMING_MOVIES),
          bloc: MovieListBloc(repository),
          child: MovieListPage(
            title: "Upcoming",
            type: Constants.UPCOMING_MOVIES,
          ),
        )
      ],
    );
  }
}
