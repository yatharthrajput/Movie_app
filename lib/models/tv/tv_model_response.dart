import 'package:the_movie_app/models/tv/tv_show_model.dart';

class TvShowResponseModel {
  int page;
  int totalResults;
  int totalPages;
  List<TvShowModel> results;

  TvShowResponseModel(
      {this.page, this.totalResults, this.totalPages, this.results});

  TvShowResponseModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalResults = json['total_results'];
    totalPages = json['total_pages'];
    if (json['results'] != null) {
      results = new List<TvShowModel>();
      json['results'].forEach((v) {
        results.add(new TvShowModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['total_results'] = this.totalResults;
    data['total_pages'] = this.totalPages;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
