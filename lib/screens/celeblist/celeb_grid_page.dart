import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie_app/bloc/celeblistbloc/bloc.dart';
import 'package:the_movie_app/repository/repository.dart';
import 'package:the_movie_app/screens/celeblist/celeb_grid.dart';
import 'package:the_movie_app/utils/keys.dart';

class CelebGridPage extends StatelessWidget {
  CelebGridPage({this.type, this.title, this.repository});

  final String type;
  final String title;
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
      body: BlocProvider<CelebListBloc>(
        key: Key(CELEB_POPULAR_LIST),
        bloc: CelebListBloc(repository),
        child: CelebGrid(
          type: type,
        ),
      ),
    );
  }
}
