import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie_app/bloc/tvshowdetailsbloc/bloc.dart';
import 'package:the_movie_app/commonwidgets/app_error_view.dart';
import 'package:the_movie_app/commonwidgets/genre_line.dart';
import 'package:the_movie_app/commonwidgets/loader.dart';
import 'package:the_movie_app/commonwidgets/actor_scroller.dart';
import 'package:the_movie_app/commonwidgets/detail_page_header.dart';
import 'package:the_movie_app/commonwidgets/photo_scroller.dart';
import 'package:the_movie_app/commonwidgets/story_line.dart';

class TvShowDetails extends StatefulWidget {
  TvShowDetails({this.id});

  final String id;

  @override
  _TvShowDetailsState createState() => _TvShowDetailsState();
}

class _TvShowDetailsState extends State<TvShowDetails> {
  TvShowDetailsBloc _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of<TvShowDetailsBloc>(context);
    _bloc.dispatch(FetchTvShowDetails(id: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _bloc,
      builder: (BuildContext context, TvShowDetailsState state) {
        if (state is InitialTvShowDetailsState) {
          return Loader();
        }

        if (state is ErrorTvShowDetailsState) {
          return ApiErrorView(
              message: "Some error occured while fetching details",
              onTap: () => _bloc.dispatch(FetchTvShowDetails(id: widget.id)));
        }

        if (state is LoadedTvShowDetailsState) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DetailsPageHeader(
                  state.detailResponse.name,
                  state.detailResponse.backdropPath,
                  state.detailResponse.posterPath,
                  averageRating: state.detailResponse.voteAverage,
                ),
                SizedBox(height: 20.0),
                GenreLine(
                  genres: state.detailResponse.genres,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: StoryLine(state.detailResponse.overview),
                ),
                PhotoScroller(
                  images: state.images,
                ),
                SizedBox(height: 20.0),
                ActorScroller(
                  casts: state.casts,
                  onTap: (int id) =>
                      Navigator.pushNamed(context, "/celebdetails/$id"),
                ),
                SizedBox(height: 50.0),
              ],
            ),
          );
        }
      },
    );
  }
}
