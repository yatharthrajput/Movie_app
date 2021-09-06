import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie_app/bloc/celeblistbloc/bloc.dart';
import 'package:the_movie_app/commonwidgets/app_error_view.dart';
import 'package:the_movie_app/commonwidgets/loader.dart';
import 'package:the_movie_app/commonwidgets/movie_view.dart';
import 'package:the_movie_app/utils/constants.dart';
import 'package:the_movie_app/utils/url_provider.dart';

class CelebListPage extends StatefulWidget {
  CelebListPage({this.title, this.type});

  final String title;
  final String type;

  @override
  _CelebListPageState createState() => _CelebListPageState();
}

class _CelebListPageState extends State<CelebListPage> {
  CelebListBloc _celebListBloc;

  @override
  void initState() {
    _celebListBloc = BlocProvider.of<CelebListBloc>(context);
    _celebListBloc.dispatch(CelebFetch(celebType: widget.type));
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
                      context, "/celeblist/${widget.type}/${widget.title}");
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
                bloc: _celebListBloc,
                builder: (BuildContext context, CelebListState state) {
                  if (state is InitialCelebListState) {
                    return Loader();
                  }

                  if (state is ErrorCelebListEstate) {
                    return ApiErrorView(
                      message: "Some Error Occurred",
                      onTap: () => _celebListBloc
                          .dispatch(CelebFetch(celebType: widget.type)),
                    );
                  }

                  if (state is LoadedCelebListEstate) {
                    if (state.celebList.isEmpty) {
                      return ApiErrorView(
                        message: "Some Error Occurred",
                        onTap: () => _celebListBloc
                            .dispatch(CelebFetch(celebType: widget.type)),
                      );
                    }

                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.celebList.length,
                        padding: const EdgeInsets.only(top: 8.0, right: 20.0),
                        itemBuilder: (context, index) {
                          return MovieView(
                            id: state.celebList[index].id,
                            title: state.celebList[index].name,
                            posterPath:
                                "$IMAGE_BASE_URL${state.celebList[index].profilePath}",
                            onTap: (int id) =>
                                Navigator.pushNamed(context, "/celebdetails/$id"),
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
