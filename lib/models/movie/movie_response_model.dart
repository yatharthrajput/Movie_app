import 'package:the_movie_app/models/movie/movie_model.dart';

class MovieResponseModel {
  num page;
  num totalResults;
  num totalPages;
  List<MovieModel> results;

  MovieResponseModel(
      {this.page, this.totalResults, this.totalPages, this.results});

  MovieResponseModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalResults = json['total_results'];
    totalPages = json['total_pages'];
    if (json['results'] != null) {
      results = List<MovieModel>();
      json['results'].forEach((v) {
        results.add( MovieModel.fromJson(v));
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
