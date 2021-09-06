import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie_app/bloc/celebdetailsbloc/bloc.dart';
import 'package:the_movie_app/repository/repository.dart';
import 'package:the_movie_app/screens/celebdetails/celeb_details.dart';

class CelebDetailsPage extends StatelessWidget {
  CelebDetailsPage({this.id, this.repository});

  final String id;
  final Repository repository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CelebDetailsBloc>(
      key: Key("CelebDetailsPage$id"),
      bloc: CelebDetailsBloc(repository: repository),
      child: Scaffold(
        body: CelebDetails(id: id),
      ),
    );
  }
}
