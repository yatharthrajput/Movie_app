import 'package:the_movie_app/models/celeb/celeb_response_model.dart';
import 'package:the_movie_app/models/celebdetails/celeb_details_response.dart';
import 'package:the_movie_app/models/celebdetails/celeb_images_response.dart';
import 'package:the_movie_app/models/celebdetails/celeb_movies_response.dart';
import 'package:the_movie_app/models/celebdetails/celeb_tv_shows_response.dart';
import 'package:the_movie_app/models/movie/movie_response_model.dart';
import 'package:the_movie_app/models/moviedetails/movie_casts_response.dart';
import 'package:the_movie_app/models/moviedetails/movie_details_response.dart';
import 'package:the_movie_app/models/moviedetails/movie_images_response.dart';
import 'package:the_movie_app/models/search/search_response.dart';
import 'package:the_movie_app/models/tv/tv_model_response.dart';
import 'package:the_movie_app/models/tvdetails/tv_image_response.dart';
import 'package:the_movie_app/models/tvdetails/tv_show_cast_response.dart';
import 'package:the_movie_app/models/tvdetails/tv_show_detail_response.dart';
import 'package:the_movie_app/repository/movie_api_provider.dart';

class Repository {
  Repository(this.moviesApiProvider);

  final MoviesApiProvider moviesApiProvider;

  //Fetch list of movies according to [movieType]
  Future<MovieResponseModel> fetchMoviesByType(String type, int page) async =>
      moviesApiProvider.fetchMovieList(type, page);

  //Fetch all details related to a movie from [id]
  Future<MovieDetailsResponse> fetchMovieDetailById(String id) =>
      moviesApiProvider.fetchMoveDetailsById(id);

  //Fetch all images related to a movie from [id]
  Future<MovieImagesResponse> fetchingMovieImages(String id) =>
      moviesApiProvider.fetchMoviesImages(id);

  //Fetch all cast of the movie from [id]
  Future<MovieCastsResponse> fetchingMovieCasts(String id) =>
      moviesApiProvider.fetchMovieCasts(id);

  //Fetch list of tv show according to [tvShowType]
  Future<TvShowResponseModel> fetchTvsByType(String tvShowType, int page) =>
      moviesApiProvider.fetchTvList(tvShowType, page);

  //Fetch Tv Show Details
  Future<TvShowDetailResponse> fetchTvShowDetails(String id) =>
      moviesApiProvider.fetchTvShowDetails(id);

  //Load images of a Tv Show
  Future<TvImageResponse> fetchTvShowImages(String id) =>
      moviesApiProvider.fetchTvShowImages(id);

  Future<TvShowCastResponse> fetchTvShowCasts(String id) =>
      moviesApiProvider.fetchTvShowCasts(id);

  //Fetch List of celebrity according to [celebType]
  Future<CelebResponseModel> fetchCelebrities(String celebType, int page) =>
      moviesApiProvider.fetchCelebrities(celebType, page);

  //Fetch details of a celebrity from id
  Future<CelebDetailsResponse> fetchCelebDetails(String id) =>
      moviesApiProvider.fetchCelebDetails(id);

  //Fetch List of images of a celeb
  Future<CelebImagesResponse> fetchCelebImages(String id) =>
      moviesApiProvider.fetchCelebImages(id);

  //Fetch list of movies of celeb
  Future<CelebMoviesResponse> fetchCelebMovies(String id) =>
      moviesApiProvider.fetchCelebMovies(id);

  //Fetch list of tv shows of celeb
  Future<CelebTvShowsResponse> fetchCelebTvShows(String id) =>
      moviesApiProvider.fetchTvShows(id);

  //Return Future fo SearchResponse
  Future<SearchResponse> search(String query, int page) =>
      moviesApiProvider.search(query, page);
}
