import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie_app/bloc/tvshowdetailsbloc/bloc.dart';
import 'package:the_movie_app/repository/repository.dart';
import 'package:the_movie_app/screens/tvdetails/tv_show_details.dart';

class TvDetailsPage extends StatelessWidget {
  TvDetailsPage({this.id, this.repository});

  final String id;
  final Repository repository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TvShowDetailsBloc>(
      key: Key("$id"),
      bloc: TvShowDetailsBloc(repository: repository),
      child: Scaffold(
        body: TvShowDetails(id: id),
      ),
    );
  }
}
