import 'package:the_movie_app/models/movie/movie_model.dart';

class CelebMoviesResponse {
  List<MovieModel> movies;
  int id;

  CelebMoviesResponse({this.movies, this.id});

  CelebMoviesResponse.fromJson(Map<String, dynamic> json) {
    if (json['cast'] != null) {
      movies = List<MovieModel>();
      json['cast'].forEach((v) {
        movies.add(new MovieModel.fromJson(v));
      });
    }

    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.movies != null) {
      data['cast'] = this.movies.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    return data;
  }
}
