import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie_app/bloc/celebdetailsbloc/bloc.dart';
import 'package:the_movie_app/commonwidgets/app_error_view.dart';
import 'package:the_movie_app/commonwidgets/detail_page_header.dart';
import 'package:the_movie_app/commonwidgets/loader.dart';
import 'package:the_movie_app/commonwidgets/movie_scroller.dart';
import 'package:the_movie_app/commonwidgets/photo_scroller.dart';
import 'package:the_movie_app/commonwidgets/story_line.dart';
import 'package:the_movie_app/commonwidgets/tv_show_scroller.dart';

class CelebDetails extends StatefulWidget {
  CelebDetails({this.id});

  final String id;

  @override
  _CelebDetailsState createState() => _CelebDetailsState();
}

class _CelebDetailsState extends State<CelebDetails> {
  CelebDetailsBloc _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of<CelebDetailsBloc>(context);
    _bloc.dispatch(FetchCelebDetails(id: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _bloc,
      builder: (BuildContext context, CelebDetailsState state) {
        if (state is InitialCelebDetailsState) {
          return Loader();
        }

        if (state is ErrorCelebDetailState) {
          return ApiErrorView(
            message: "Some error occurred",
            onTap: () {
              _bloc.dispatch(FetchCelebDetails(id: widget.id));
            },
          );
        }

        if (state is LoadedCelebDetailState) {
          return SingleChildScrollView(
            child: Column(
              children: [
                DetailsPageHeader(
                  state.detailsResponse.name,
                  state.detailsResponse.profilePath,
                  state.detailsResponse.profilePath,
                  averageRating: 0,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: StoryLine(state.detailsResponse.biography),
                ),
                SizedBox(height: 20.0),
                PhotoScroller(
                  images: state.images,
                ),
                SizedBox(height: 20.0),
                state.movies.isNotEmpty
                    ? Column(
                        children: <Widget>[
                          MovieScroller(movies: state.movies),
                          SizedBox(height: 20.0),
                        ],
                      )
                    : Container(),
                state.tvShows.isNotEmpty
                    ? Column(
                        children: <Widget>[
                          TvShowScroller(tvShows: state.tvShows),
                          SizedBox(height: 20.0),
                        ],
                      )
                    : Container(),
                SizedBox(height: 50.0),
              ],
            ),
          );
        }
      },
    );
  }
}
