import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie_app/bloc/movielistbloc/movie_fetch.dart';
import 'package:the_movie_app/bloc/movielistbloc/movie_list_bloc.dart';
import 'package:the_movie_app/bloc/movielistbloc/movie_state.dart';
import 'package:the_movie_app/commonwidgets/app_error_view.dart';
import 'package:the_movie_app/commonwidgets/loader.dart';
import 'package:the_movie_app/commonwidgets/movie_view.dart';
import 'package:the_movie_app/utils/constants.dart';
import 'package:the_movie_app/utils/url_provider.dart';

class MovieListPage extends StatefulWidget {
  MovieListPage({this.title, this.type});

  final String title;
  final String type;

  @override
  _MovieListPageState createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  MovieListBloc _movieListBloc;

  @override
  void initState() {
    _movieListBloc = BlocProvider.of<MovieListBloc>(context);
    _movieListBloc.dispatch(Fetch(widget.type));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                widget.title,
                style: Theme.of(context).textTheme.headline,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                      context, "/movielist/${widget.type}/${widget.title}");
                },
                child: Text(
                  "View all",
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.deepPurpleAccent),
                ),
              )
            ],
          ),
          SizedBox.fromSize(
            size: const Size.fromHeight(250.0),
            child: BlocBuilder(
                bloc: _movieListBloc,
                builder: (BuildContext context, MovieState state) {
                  if (state is MovieUnInitialized) {
                    return Loader();
                  }

                  if (state is MovieError) {
                    return ApiErrorView(
                      message: "Some Error Occurred",
                      onTap: () => _movieListBloc.dispatch(Fetch(widget.type)),
                    );
                  }

                  if (state is MovieLoaded) {
                    if (state.movieList.isEmpty) {
                      return ApiErrorView(
                        message: "Some Error Occurred",
                        onTap: () =>
                            _movieListBloc.dispatch(Fetch(widget.type)),
                      );
                    }

                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.movieList.length,
                        padding: const EdgeInsets.only(top: 8.0, right: 20.0),
                        itemBuilder: (context, index) {
                          return MovieView(
                            id: state.movieList[index].id,
                            title: state.movieList[index].title,
                            posterPath:
                                "$IMAGE_BASE_URL${state.movieList[index].posterPath}",
                            onTap: (int id) =>
                                Navigator.pushNamed(context, "/details/$id"),
                          );
                        });
                  }
                }),
          )
        ],
      ),
    );
  }
}
