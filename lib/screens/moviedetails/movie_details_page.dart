import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie_app/bloc/moviedetailsbloc/bloc.dart';
import 'package:the_movie_app/repository/repository.dart';
import 'package:the_movie_app/screens/moviedetails/movie_details.dart';

class MovieDetailsPage extends StatelessWidget {
  MovieDetailsPage({this.id, this.repository});

  final String id;
  final Repository repository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieDetailsBloc>(
      key: Key("MovieDetailsPage$id"),
      bloc: MovieDetailsBloc(repository: repository),
      child: Scaffold(
        body: MovieDetails(id: id),
      ),
    );
  }
}
