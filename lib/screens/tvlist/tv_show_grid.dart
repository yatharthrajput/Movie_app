import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie_app/bloc/tvlistbloc/tv_show_list_bloc.dart';
import 'package:the_movie_app/bloc/tvlistbloc/tv_show_list_event.dart';
import 'package:the_movie_app/bloc/tvlistbloc/tv_show_list_state.dart';
import 'package:the_movie_app/commonwidgets/bottom_loader.dart';
import 'package:the_movie_app/commonwidgets/loader.dart';
import 'package:the_movie_app/commonwidgets/movie_view.dart';
import 'package:the_movie_app/utils/constants.dart';
import 'package:the_movie_app/utils/url_provider.dart';

class TvShowGrid extends StatefulWidget {
  TvShowGrid({this.type});

  final String type;

  @override
  _TvShowGridState createState() => _TvShowGridState();
}

class _TvShowGridState extends State<TvShowGrid> {
  final ScrollController _scrollController = new ScrollController();
  TvShowListBloc _tvShowBloc;
  final double _scrollThreshold = 200.0;

  @override
  void initState() {
    //Scroll listener on list
    _scrollController.addListener(this.onScroll);
    //Get Instance of _tvShowBloc from BlocProvider
    _tvShowBloc = BlocProvider.of<TvShowListBloc>(context);
    //Load list of tv shows
    _tvShowBloc.dispatch(TvShowFetch(tvShowType: widget.type));
    super.initState();
  }

  @override
  void dispose() {
    // Dispose the bloc if no longer used to avoid memory leaks
    _tvShowBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _tvShowBloc,
      builder: (BuildContext context, TvShowListState state) {
        //Show a Linear Loader when loading the list for the first time
        if (state is InitialTvShowListState) {
          return Loader();
        }
        //Show a empty placeholder in case of Error while fetching Tv Shows
        if (state is ErrorTvShowListState) {
          return Center(
            child: Text('Failed to load Tv Show List'),
          );
        }

        //Show a empty view if list is empty
        if (state is LoadedTvShowListState) {
          if (state.tvShowList.isEmpty) {
            return Center(
              child: Text('No Tv show found'),
            );
          }

          return Container(
            margin: const EdgeInsets.only(left: 12.0),
            child: GridView.builder(
              controller: _scrollController,
              //If Last Page data is loaded the return the actual size of the list otherwise increase the length of list by 1 to show a bottom loader
              itemCount: state.hasMaxReached
                  ? state.tvShowList.length
                  : state.tvShowList.length + 1,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: Platform.isAndroid ? 0.59 : 0.54,
              ),
              itemBuilder: (BuildContext context, int index) {
                //If Index is greater than equal to the length of the list then return Loader otherwise return actual view widget
                return index >= state.tvShowList.length
                    ? BottomLoader()
                    : MovieView(
                        id: state.tvShowList[index].id,
                        title: state.tvShowList[index].name,
                        posterPath: state.tvShowList[index].posterPath != null
                            ? "$IMAGE_BASE_URL${state.tvShowList[index].posterPath}"
                            : "$PLACEHOLDER_URL_150",
                        onTap: (int id) =>
                            Navigator.pushNamed(context, "/tvdetails/$id"),
                      );
              },
            ),
          );
        }
      },
    );
  }

  //Check if we reached the end of the list. If Reached : dispatch load event to load new page data
  void onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (maxScroll - currentScroll <= _scrollThreshold) {
      _tvShowBloc.dispatch(TvShowFetch(tvShowType: widget.type));
    }
  }
}
