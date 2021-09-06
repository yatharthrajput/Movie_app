import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie_app/bloc/searchbloc/bloc.dart';
import 'package:the_movie_app/repository/repository.dart';
import 'package:the_movie_app/screens/search/search_grid.dart';

class SearchGridPage extends StatelessWidget {
  SearchGridPage({this.query, this.repository});

  final String query;
  final Repository repository;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocProvider<SearchBloc>(
      bloc: SearchBloc(repository: repository),
      key: Key("search_$query"),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.primaryColor,
          elevation: 2.0,
          centerTitle: false,
          title: Text(
            query,
            style: theme.textTheme.title.copyWith(color: Colors.white),
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: SearchGrid(query: query),
      ),
    );
  }
}
