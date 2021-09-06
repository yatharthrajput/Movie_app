class Images {
  num width;
  num height;
  num voteCount;
  num voteAverage;
  String filePath;
  num aspectRatio;

  Images(
      {this.width,
      this.height,
      this.voteCount,
      this.voteAverage,
      this.filePath,
      this.aspectRatio});

  Images.fromJson(Map<String, dynamic> json) {
    width = json['width'];
    height = json['height'];
    voteCount = json['vote_count'];
    voteAverage = json['vote_average'];
    filePath = json['file_path'];
    aspectRatio = json['aspect_ratio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['width'] = this.width;
    data['height'] = this.height;
    data['vote_count'] = this.voteCount;
    data['vote_average'] = this.voteAverage;
    data['file_path'] = this.filePath;
    data['aspect_ratio'] = this.aspectRatio;
    return data;
  }
}
