import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie_app/bloc/searchbloc/bloc.dart';
import 'package:the_movie_app/commonwidgets/bottom_loader.dart';
import 'package:the_movie_app/commonwidgets/loader.dart';
import 'package:the_movie_app/commonwidgets/movie_view.dart';
import 'package:the_movie_app/utils/constants.dart';
import 'package:the_movie_app/utils/url_provider.dart';

class SearchGrid extends StatefulWidget {
  SearchGrid({this.query});

  final String query;

  @override
  _SearchGridState createState() => _SearchGridState();
}

class _SearchGridState extends State<SearchGrid> {
  SearchBloc _bloc;
  final ScrollController _scrollController = ScrollController();
  final double scrollThreshold = 200.0;

  _SearchGridState() {
    _scrollController.addListener(this.onScroll);
  }

  @override
  void initState() {
    _bloc = BlocProvider.of<SearchBloc>(context);
    _bloc.dispatch(SearchSubmitEvent(query: widget.query));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _bloc,
      key: Key("SearchGrid_${widget.query}"),
      builder: (BuildContext context, SearchState state) {
        if (state is InitialSearchState) {
          return Loader();
        }

        if (state is EmptySearchState) {
          return Center(
            child: Text('Failed to load movies'),
          );
        }

        if (state is ErrorSearchState) {
          return Center(
            child: Text('Failed to load movies'),
          );
        }

        if (state is LoadedSearchState) {
          if (state.searchList.isEmpty) {
            return Center(
              child: Text("No data found"),
            );
          }
          return Container(
            margin: const EdgeInsets.only(left: 12),
            child: GridView.builder(
              itemCount: state.hasMaxReached
                  ? state.searchList.length
                  : state.searchList.length + 1,
              controller: _scrollController,
              padding: const EdgeInsets.all(2),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: Platform.isAndroid ? 0.59 : 0.54,
              ),
              itemBuilder: (BuildContext context, int index) {
                return index >= state.searchList.length
                    ? BottomLoader()
                    : MovieView(
                        id: state.searchList[index].id,
                        title: state.searchList[index].title ??
                            state.searchList[index].name,
                        posterPath: state.searchList[index].posterPath != null
                            ? "$IMAGE_BASE_URL${state.searchList[index].posterPath}"
                            : "$PLACEHOLDER_URL_150",
                        onTap: (int id) {
                          switch (state.searchList[index].mediaType) {
                            case "tv":
                              Navigator.pushNamed(context, "/tvdetails/$id");
                              break;
                            case "movie":
                              Navigator.pushNamed(context, "/details/$id");
                              break;
                          }
                        },
                      );
              },
            ),
          );
        }
      },
    );
    ;
  }

  void onScroll() {
    final double maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (maxScroll - currentScroll <= scrollThreshold) {
      _bloc.dispatch(SearchSubmitEvent(query: widget.query));
    }
  }
}
