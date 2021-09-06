import 'package:the_movie_app/models/common/images.dart';

class TvImageResponse {
  num id;
  List<Images> backdrops;
  List<Images> posters;

  TvImageResponse({this.id, this.backdrops, this.posters});

  TvImageResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['backdrops'] != null) {
      backdrops = new List<Images>();
      json['backdrops'].forEach((v) {
        backdrops.add(new Images.fromJson(v));
      });
    }
    if (json['posters'] != null) {
      posters = new List<Images>();
      json['posters'].forEach((v) {
        posters.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.backdrops != null) {
      data['backdrops'] = this.backdrops.map((v) => v.toJson()).toList();
    }
    if (this.posters != null) {
      data['posters'] = this.posters.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
