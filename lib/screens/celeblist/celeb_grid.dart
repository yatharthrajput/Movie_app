import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie_app/bloc/celeblistbloc/bloc.dart';
import 'package:the_movie_app/commonwidgets/app_error_view.dart';
import 'package:the_movie_app/commonwidgets/bottom_loader.dart';
import 'package:the_movie_app/commonwidgets/loader.dart';
import 'package:the_movie_app/commonwidgets/movie_view.dart';
import 'package:the_movie_app/utils/constants.dart';
import 'package:the_movie_app/utils/url_provider.dart';

class CelebGrid extends StatefulWidget {
  CelebGrid({this.type});

  final String type;

  @override
  _CelebGridState createState() => _CelebGridState();
}

class _CelebGridState extends State<CelebGrid> {
  final ScrollController _scrollController = ScrollController();
  CelebListBloc _celebListBloc;
  final double _scrollThreshold = 200.0;

  @override
  void initState() {
    //Scroll listener on list
    _scrollController.addListener(this.onScroll);

    //Get Instance of _celebListBloc from BlocProvider
    _celebListBloc = BlocProvider.of<CelebListBloc>(context);

    //Load list of celebs
    _celebListBloc.dispatch(CelebFetch(celebType: widget.type));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _celebListBloc,
      builder: (BuildContext context, CelebListState state) {
        if (state is InitialCelebListState) {
          return Loader();
        }

        if (state is ErrorCelebListEstate) {
          return ApiErrorView(
            message: "Some error occurred while loading celebs",
            onTap: () =>
                _celebListBloc.dispatch(CelebFetch(celebType: widget.type)),
          );
        }

        if (state is LoadedCelebListEstate) {
          if (state.celebList.isEmpty) {
            return ApiErrorView(
              message: "No Celebs Found",
              onTap: () =>
                  _celebListBloc.dispatch(CelebFetch(celebType: widget.type)),
            );
          }

          return Container(
            margin: const EdgeInsets.only(left: 12.0),
            child: GridView.builder(
              controller: _scrollController,
              //[hasMaxReached : true] - Items of last page is loaded then return actual size of the list.
              // Otherwise increment the list size of by to show a bottom loader.
              itemCount: state.hasMaxReached
                  ? state.celebList.length
                  : state.celebList.length + 1,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: Platform.isAndroid ? 0.59 : 0.54,
              ),
              itemBuilder: (BuildContext context, int index) {
                //if the index is greater than equal to the length of the list then return BottomLoader for fetching more items
                return index >= state.celebList.length
                    ? BottomLoader()
                    : MovieView(
                        id: state.celebList[index].id,
                        title: state.celebList[index].name,
                        posterPath: state.celebList[index].profilePath != null
                            ? "$IMAGE_BASE_URL${state.celebList[index].profilePath}"
                            : "$PLACEHOLDER_URL_150",
                        onTap: (int id) =>
                            Navigator.pushNamed(context, "/celebdetails/$id"),
                      );
              },
            ),
          );
        }
      },
    );
  }

  void onScroll() {
    final double maxScroll = _scrollController.position.maxScrollExtent;
    final double currentScroll = _scrollController.position.pixels;

    if (maxScroll - currentScroll <= _scrollThreshold) {
      _celebListBloc.dispatch(CelebFetch(celebType: widget.type));
    }
  }
}
