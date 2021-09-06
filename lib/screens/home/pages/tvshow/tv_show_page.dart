import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie_app/bloc/tvlistbloc/bloc.dart';
import 'package:the_movie_app/repository/repository.dart';
import 'package:the_movie_app/screens/home/pages/tvshow/tv_show_list_page.dart';
import 'package:the_movie_app/utils/constants.dart';
import 'package:the_movie_app/utils/keys.dart';

class TvShowPage extends StatelessWidget {
  TvShowPage({@required this.repository});

  final Repository repository;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        BlocProvider<TvShowListBloc>(
          key: Key(TV_SHOW_POPULAR_LIST),
          bloc: TvShowListBloc(repository),
          child: TvShowListPage(
            title: "Most Popular",
            type: Constants.POPULAR_MOVIES,
          ),
        ),
        BlocProvider<TvShowListBloc>(
          key: Key(TV_SHOW_AIRING_TODAY_LIST),
          bloc: TvShowListBloc(repository),
          child: TvShowListPage(
            title: "Airing Today",
            type: Constants.AIRING_TODAY,
          ),
        ),
        BlocProvider<TvShowListBloc>(
          key: Key(TV_SHOW_ON_AIR_LIST),
          bloc: TvShowListBloc(repository),
          child: TvShowListPage(
            title: "On The Air",
            type: Constants.ON_THE_AIR,
          ),
        ),
        BlocProvider<TvShowListBloc>(
          key: Key(TV_SHOW_TOP_RATED_LIST),
          bloc: TvShowListBloc(repository),
          child: TvShowListPage(
            title: "Top Rated",
            type: Constants.TOP_RATED_MOVIES,
          ),
        )
      ],
    );
  }
}
