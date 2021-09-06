import 'package:flutter/material.dart';
import 'package:the_movie_app/models/common/genres.dart';

class GenreLine extends StatelessWidget {
  GenreLine({this.genres});

  final List<Genres> genres;

  List<Widget> _buildCategoryChips(TextTheme textTheme) {
    return genres.map((category) {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Chip(
            label: Text(category.name),
            labelStyle: textTheme.caption,
            backgroundColor: Colors.black12,
          ));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Wrap(
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.start,
          direction: Axis.horizontal,
          children: _buildCategoryChips(textTheme),
        ),
      ),
    );
  }
}
