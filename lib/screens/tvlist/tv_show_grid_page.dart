import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie_app/bloc/tvlistbloc/bloc.dart';
import 'package:the_movie_app/repository/repository.dart';
import 'package:the_movie_app/screens/tvlist/tv_show_grid.dart';

class TvShowGridPage extends StatelessWidget {
  TvShowGridPage({this.title, this.type, this.repository});

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
      body: BlocProvider<TvShowListBloc>(
        bloc: TvShowListBloc(repository),
        child: TvShowGrid(
          type: type,
        ),
      ),
    );
  }
}

/*
class TvShowGridPage extends StatefulWidget {
  TvShowGridPage({this.tvShowType, this.title});

  final String tvShowType;
  final String title;

  @override
  _TvShowGridPageState createState() => _TvShowGridPageState();
}

class _TvShowGridPageState extends State<TvShowGridPage> {
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
      body: TvShowGrid(
        tvShowType: widget.tvShowType,
      ),
    );
  }
}
*/
