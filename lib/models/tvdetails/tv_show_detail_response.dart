import 'package:the_movie_app/models/common/genres.dart';
import 'package:the_movie_app/models/tvdetails/seasons_model.dart';

class TvShowDetailResponse {
  String backdropPath;
  String firstAirDate;
  List<Genres> genres;
  String homepage;
  num id;
  bool inProduction;
  List<String> languages;
  String lastAirDate;
  String name;
  num numberOfEpisodes;
  num numberOfSeasons;
  String originalLanguage;
  String originalName;
  String overview;
  num popularity;
  String posterPath;
  List<SeasonsModel> seasons;
  String status;
  String type;
  num voteAverage;
  num voteCount;

  TvShowDetailResponse(
      {this.backdropPath,
      this.firstAirDate,
      this.genres,
      this.homepage,
      this.id,
      this.inProduction,
      this.languages,
      this.lastAirDate,
      this.name,
      this.numberOfEpisodes,
      this.numberOfSeasons,
      this.originalLanguage,
      this.originalName,
      this.overview,
      this.popularity,
      this.posterPath,
      this.seasons,
      this.status,
      this.type,
      this.voteAverage,
      this.voteCount});

  TvShowDetailResponse.fromJson(Map<String, dynamic> json) {
    backdropPath = json['backdrop_path'];

    firstAirDate = json['first_air_date'];
    if (json['genres'] != null) {
      genres = new List<Genres>();
      json['genres'].forEach((v) {
        genres.add(new Genres.fromJson(v));
      });
    }
    homepage = json['homepage'];
    id = json['id'];
    inProduction = json['in_production'];
    languages = json['languages'].cast<String>();
    lastAirDate = json['last_air_date'];
    name = json['name'];
    numberOfEpisodes = json['number_of_episodes'];
    numberOfSeasons = json['number_of_seasons'];
    originalLanguage = json['original_language'];
    originalName = json['original_name'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];

    if (json['seasons'] != null) {
      seasons = new List<SeasonsModel>();
      json['seasons'].forEach((v) {
        seasons.add(new SeasonsModel.fromJson(v));
      });
    }
    status = json['status'];
    type = json['type'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['backdrop_path'] = this.backdropPath;
    data['first_air_date'] = this.firstAirDate;
    if (this.genres != null) {
      data['genres'] = this.genres.map((v) => v.toJson()).toList();
    }
    data['homepage'] = this.homepage;
    data['id'] = this.id;
    data['in_production'] = this.inProduction;
    data['languages'] = this.languages;
    data['last_air_date'] = this.lastAirDate;
    data['name'] = this.name;
    data['number_of_episodes'] = this.numberOfEpisodes;
    data['number_of_seasons'] = this.numberOfSeasons;
    data['original_language'] = this.originalLanguage;
    data['original_name'] = this.originalName;
    data['overview'] = this.overview;
    data['popularity'] = this.popularity;
    data['poster_path'] = this.posterPath;
    if (this.seasons != null) {
      data['seasons'] = this.seasons.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['type'] = this.type;
    data['vote_average'] = this.voteAverage;
    data['vote_count'] = this.voteCount;
    return data;
  }
}
