import 'package:the_movie_app/models/movie/movie_model.dart';

class CelebModel {
  num popularity;
  num id;
  String profilePath;
  String name;
  List<MovieModel> knownFor;
  bool adult;

  CelebModel(
      {this.popularity,
      this.id,
      this.profilePath,
      this.name,
      this.knownFor,
      this.adult});

  CelebModel.fromJson(Map<String, dynamic> json) {
    popularity = json['popularity'];
    id = json['id'];
    profilePath = json['profile_path'];
    name = json['name'];
    if (json['known_for'] != null) {
      knownFor = new List<MovieModel>();
      json['known_for'].forEach((v) {
        knownFor.add(new MovieModel.fromJson(v));
      });
    }
    adult = json['adult'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['popularity'] = this.popularity;
    data['id'] = this.id;
    data['profile_path'] = this.profilePath;
    data['name'] = this.name;
    if (this.knownFor != null) {
      data['known_for'] = this.knownFor.map((v) => v.toJson()).toList();
    }
    data['adult'] = this.adult;
    return data;
  }
}
