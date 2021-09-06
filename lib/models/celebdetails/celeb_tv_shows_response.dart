import 'package:the_movie_app/models/tv/tv_show_model.dart';

class CelebTvShowsResponse {
  List<TvShowModel> tvShows;
  num id;

  CelebTvShowsResponse({this.tvShows, this.id});

  CelebTvShowsResponse.fromJson(Map<String, dynamic> json) {
    if (json['cast'] != null) {
      tvShows = List<TvShowModel>();
      json['cast'].forEach((v) {
        tvShows.add(new TvShowModel.fromJson(v));
      });
    }

    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tvShows != null) {
      data['cast'] = this.tvShows.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    return data;
  }
}
