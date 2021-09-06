import 'package:the_movie_app/models/search/search.dart';

class SearchResponse {
  int page;
  int totalResults;
  int totalPages;
  List<Search> results;

  SearchResponse({this.page, this.totalResults, this.totalPages, this.results});

  SearchResponse.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalResults = json['total_results'];
    totalPages = json['total_pages'];
    if (json['results'] != null) {
      results = new List<Search>();
      json['results'].forEach((v) {
        results.add(new Search.fromJson(v));
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
