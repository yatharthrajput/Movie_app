import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie_app/bloc/movielistbloc/movie_fetch.dart';
import 'package:the_movie_app/bloc/movielistbloc/movie_list_bloc.dart';
import 'package:the_movie_app/bloc/movielistbloc/movie_state.dart';
import 'package:the_movie_app/commonwidgets/bottom_loader.dart';
import 'package:the_movie_app/commonwidgets/loader.dart';
import 'package:the_movie_app/commonwidgets/movie_view.dart';
import 'package:the_movie_app/utils/constants.dart';
import 'package:the_movie_app/utils/url_provider.dart';

class MovieGridView extends StatefulWidget {
  MovieGridView({this.type});

  final String type;

  @override
  _MovieGridViewState createState() => _MovieGridViewState();
}

class _MovieGridViewState extends State<MovieGridView> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  MovieListBloc movieListBloc;

  _MovieGridViewState() {
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: movieListBloc,
      key: Key(widget.type),
      builder: (BuildContext context, MovieState state) {
        if (state is MovieUnInitialized) {
          return Loader();
        }

        if (state is MovieError) {
          return Center(
            child: Text('Failed to load movies'),
          );
        }

        if (state is MovieLoaded) {
          if (state.movieList.isEmpty) {
            return Center(
              child: Text("No movies found"),
            );
          }
          return Container(
            margin: const EdgeInsets.only(left: 12),
            child: GridView.builder(
              itemCount: state.hasReachedMax
                  ? state.movieList.length
                  : state.movieList.length + 1,
              controller: _scrollController,
              padding: const EdgeInsets.all(2),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: Platform.isAndroid ? 0.59 : 0.54,
              ),
              itemBuilder: (BuildContext context, int index) {
                return index >= state.movieList.length
                    ? BottomLoader()
                    : MovieView(
                        id: state.movieList[index].id,
                        title: state.movieList[index].title,
                        posterPath: state.movieList[index].posterPath != null
                            ? "$IMAGE_BASE_URL${state.movieList[index].posterPath}"
                            : "$PLACEHOLDER_URL_150",
                        onTap: (int id) {
                          Navigator.pushNamed(context, "/details/$id");
                        },
                      );
              },
            ),
          );
        }
      },
    );
  }

  @override
  void initState() {
    movieListBloc = BlocProvider.of<MovieListBloc>(context);
    movieListBloc.dispatch(Fetch(widget.type));
    super.initState();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      movieListBloc.dispatch(Fetch(widget.type));
    }
  }
}
