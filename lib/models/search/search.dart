class Search {
  num voteAverage;
  num voteCount;
  num id;
  bool video;
  String mediaType;
  String title;
  String name;
  double popularity;
  String posterPath;
  String originalLanguage;
  String originalTitle;
  String backdropPath;
  bool adult;
  String overview;
  String releaseDate;

  Search(
      {this.voteAverage,
      this.voteCount,
      this.id,
      this.video,
      this.mediaType,
      this.title,
      this.name,
      this.popularity,
      this.posterPath,
      this.originalLanguage,
      this.originalTitle,
      this.backdropPath,
      this.adult,
      this.overview,
      this.releaseDate});

  Search.fromJson(Map<String, dynamic> json) {
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    id = json['id'];
    video = json['video'];
    mediaType = json['media_type'];
    title = json['title'];
    name = json["name"];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    backdropPath = json['backdrop_path'];
    adult = json['adult'];
    overview = json['overview'];
    releaseDate = json['release_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['vote_average'] = this.voteAverage;
    data['vote_count'] = this.voteCount;
    data['id'] = this.id;
    data['video'] = this.video;
    data['media_type'] = this.mediaType;
    data['title'] = this.title;
    data['name'] = this.name;
    data['popularity'] = this.popularity;
    data['poster_path'] = this.posterPath;
    data['original_language'] = this.originalLanguage;
    data['original_title'] = this.originalTitle;
    data['backdrop_path'] = this.backdropPath;
    data['adult'] = this.adult;
    data['overview'] = this.overview;
    data['release_date'] = this.releaseDate;
    return data;
  }
}
