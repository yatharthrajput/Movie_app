import 'package:the_movie_app/models/celeb/celeb_model.dart';

class CelebResponseModel {
  num page;
  num totalResults;
  num totalPages;
  List<CelebModel> results;

  CelebResponseModel(
      {this.page, this.totalResults, this.totalPages, this.results});

  CelebResponseModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalResults = json['total_results'];
    totalPages = json['total_pages'];
    if (json['results'] != null) {
      results = new List<CelebModel>();
      json['results'].forEach((v) {
        results.add(new CelebModel.fromJson(v));
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
