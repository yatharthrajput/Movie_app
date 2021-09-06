import 'package:the_movie_app/models/common/images.dart';

class CelebImagesResponse {
  List<Images> images;
  num id;

  CelebImagesResponse({this.images, this.id});

  CelebImagesResponse.fromJson(Map<String, dynamic> json) {
    if (json['profiles'] != null) {
      images = List<Images>();
      json['profiles'].forEach((v) {
        images.add(Images.fromJson(v));
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.images != null) {
      data['profiles'] = this.images.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    return data;
  }
}
