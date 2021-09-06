import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie_app/bloc/celeblistbloc/bloc.dart';
import 'package:the_movie_app/repository/repository.dart';
import 'package:the_movie_app/screens/home/pages/celeb/celeb_list_page.dart';
import 'package:the_movie_app/utils/constants.dart';
import 'package:the_movie_app/utils/keys.dart';

class CelebsPage extends StatelessWidget {
  CelebsPage({this.repository});

  final Repository repository;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        BlocProvider<CelebListBloc>(
          key: Key(CELEB_POPULAR_LIST),
          bloc: CelebListBloc(repository),
          child: CelebListPage(
            title: "Most Popular",
            type: Constants.POPULAR_MOVIES,
          ),
        ),
      ],
    );
    ;
  }
}
