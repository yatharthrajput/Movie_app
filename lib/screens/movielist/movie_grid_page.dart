import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie_app/bloc/movielistbloc/movie_list_bloc.dart';
import 'package:the_movie_app/repository/repository.dart';
import 'package:the_movie_app/screens/movielist/movie_grid.dart';

class MovieGridPage extends StatelessWidget {
  MovieGridPage({this.title, this.type, this.repository});

  final String title;
  final String type;
  final Repository repository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          title,
        ),
      ),
      body: BlocProvider<MovieListBloc>(
        key: Key(type),
        bloc: MovieListBloc(repository),
        child: MovieGridView(type: type),
      ),
    );
  }
}

/*
class MovieGridPage extends StatefulWidget {
  MovieGridPage(this.movieType, this.title, this.repository);

  final String movieType;
  final String title;
  final Repository repository;

  @override
  _MovieGridPageState createState() => _MovieGridPageState();
}

class _MovieGridPageState extends State<MovieGridPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          widget.title,
        ),
      ),
      body: BlocProvider<MovieListBloc>(
        key: Key(widget.movieType),
        bloc: MovieListBloc(widget.repository),
        child: MovieGridView(movieType: widget.movieType),
      ),
    );
  }
}*/
