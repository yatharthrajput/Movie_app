import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie_app/bloc/tvlistbloc/bloc.dart';
import 'package:the_movie_app/commonwidgets/app_error_view.dart';
import 'package:the_movie_app/commonwidgets/loader.dart';
import 'package:the_movie_app/commonwidgets/movie_view.dart';
import 'package:the_movie_app/utils/constants.dart';
import 'package:the_movie_app/utils/url_provider.dart';

class TvShowListPage extends StatefulWidget {
  TvShowListPage({this.title, this.type});

  final String title;
  final String type;

  @override
  _TvShowListPageState createState() => _TvShowListPageState();
}

class _TvShowListPageState extends State<TvShowListPage> {
  TvShowListBloc _tvListBloc;

  @override
  void initState() {
    _tvListBloc = BlocProvider.of<TvShowListBloc>(context);
    _tvListBloc.dispatch(TvShowFetch(tvShowType: widget.type));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                widget.title,
                style: Theme.of(context).textTheme.headline,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                      context, "/tvlist/${widget.type}/${widget.title}");
                },
                child: Text(
                  "View all",
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.deepPurpleAccent),
                ),
              )
            ],
          ),
          SizedBox.fromSize(
            size: const Size.fromHeight(250.0),
            child: BlocBuilder(
                bloc: _tvListBloc,
                builder: (BuildContext context, TvShowListState state) {
                  if (state is InitialTvShowListState) {
                    return Loader();
                  }

                  if (state is ErrorTvShowListState) {
                    return ApiErrorView(
                        message: "Some Error Occurred",
                        onTap: () => _tvListBloc
                            .dispatch(TvShowFetch(tvShowType: widget.type)));
                  }

                  if (state is LoadedTvShowListState) {
                    if (state.tvShowList.isEmpty) {
                      return ApiErrorView(
                          message: "Some Error Occurred",
                          onTap: () => _tvListBloc
                              .dispatch(TvShowFetch(tvShowType: widget.type)));
                    }

                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.tvShowList.length,
                        padding: const EdgeInsets.only(top: 8.0, right: 20.0),
                        itemBuilder: (context, index) {
                          return MovieView(
                            id: state.tvShowList[index].id,
                            title: state.tvShowList[index].name,
                            posterPath:
                                "$IMAGE_BASE_URL${state.tvShowList[index].posterPath}",
                            onTap: (int id) =>
                                Navigator.pushNamed(context, "/tvdetails/$id"),
                          );
                        });
                  }
                }),
          )
        ],
      ),
    );
  }
}
