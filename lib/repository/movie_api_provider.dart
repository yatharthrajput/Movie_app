import 'dart:convert';

import 'package:http/http.dart' as http;
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
import 'package:the_movie_app/repository/cache_response_provider.dart';
import 'package:the_movie_app/utils/constants.dart';
import 'package:the_movie_app/utils/url_provider.dart';
import 'package:the_movie_app/utils/api_secrets.dart';

class MoviesApiProvider {
  MoviesApiProvider(this.responseCache);

  final CacheProvider responseCache;

  /*
   *
   *  Movies APIs - All APIs related to movies
   *  
   */

  //Method to fetch list of Movies
  Future<MovieResponseModel> fetchMovieList(String type, int page) async {
    //Check if hashmap contains the response
    if (responseCache.contains("movie_$type$page")) {
      return responseCache.get("movie_$type$page");
    } else {
      final response = await http
          .get("$BASE_URL$MOVIE_URL$type?api_key=$TMDB_API_KEY&page=$page");
      if (response.statusCode == 200) {
        final result = MovieResponseModel.fromJson(json.decode(response.body));
        responseCache.set("movie_$type$page", result);
        return responseCache.get("movie_$type$page");
      } else {
        throw Exception("Failed to load movies list");
      }
    }
  }

  //Method to fetch movie details
  Future<MovieDetailsResponse> fetchMoveDetailsById(String id) async {
    if (responseCache.contains("movie_details_$id")) {
      return responseCache.get("movie_details_$id");
    } else {
      final response =
          await http.get("$BASE_URL$MOVIE_URL$id?api_key=$TMDB_API_KEY");

      if (response.statusCode == 200) {
        final result =
            MovieDetailsResponse.fromJson(json.decode(response.body));
        responseCache.set("movie_details_$id", result);
        return result;
      } else {
        throw Exception("Failed to laod movie details");
      }
    }
  }

  //Method to list all images of a movie
  Future<MovieImagesResponse> fetchMoviesImages(String id) async {
    if (responseCache.contains("movie_images_$id")) {
      return responseCache.get("movie_images_$id");
    } else {
      final response =
          await http.get("$BASE_URL$MOVIE_URL$id/images?api_key=$TMDB_API_KEY");

      if (response.statusCode == 200) {
        final result = MovieImagesResponse.fromJson(json.decode(response.body));
        responseCache.set("movie_images_$id", result);
        return result;
      } else {
        throw Exception("All images not loaded");
      }
    }
  }

  //Method to list all casts of a movie
  Future<MovieCastsResponse> fetchMovieCasts(String id) async {
    if (responseCache.contains("movie_celebs_$id")) {
      return responseCache.get("movie_celebs_$id");
    } else {
      final response = await http
          .get("$BASE_URL$MOVIE_URL$id/credits?api_key=$TMDB_API_KEY");

      if (response.statusCode == 200) {
        final result = MovieCastsResponse.fromJson(json.decode(response.body));
        responseCache.set("movie_celebs_$id", result);
        return result;
      } else {
        throw Exception("Movie cast not Loaded");
      }
    }
  }

  /*
   *
   *  Tv Show APIs - All APIs related to Tv Shows
   *  
   */

  //Method to fetch list of tv shows
  Future<TvShowResponseModel> fetchTvList(String type, int page) async {
    if (responseCache.contains("tv_show_$type$page")) {
      return responseCache.get("tv_show_$type$page");
    } else {
      final response = await http
          .get("$BASE_URL$TV_URL$type?api_key=$TMDB_API_KEY&page=$page");

      if (response.statusCode == 200) {
        final result = TvShowResponseModel.fromJson(json.decode(response.body));
        responseCache.set("tv_show_$type$page", result);
        return result;
      } else {
        throw Exception("Failed to load movies list");
      }
    }
  }

  //Method to fetch Tv Show Details
  Future<TvShowDetailResponse> fetchTvShowDetails(String id) async {
    if (responseCache.contains("tv_show_$id")) {
      return responseCache.get("tv_show_$id");
    } else {
      final response =
          await http.get("$BASE_URL$TV_URL$id?api_key=$TMDB_API_KEY");
      if (response.statusCode == 200) {
        final result =
            TvShowDetailResponse.fromJson(json.decode(response.body));
        responseCache.set("tv_show_$id", result);
        return result;
      } else {
        throw Exception("Some error occured while loading Tv Show Details");
      }
    }
  }

  //Method to list all images of a movie
  Future<TvImageResponse> fetchTvShowImages(String id) async {
    if (responseCache.contains("tv_show_images_$id")) {
      return responseCache.get("tv_show_images_$id");
    } else {
      final response =
          await http.get("$BASE_URL$TV_URL$id/images?api_key=$TMDB_API_KEY");

      if (response.statusCode == 200) {
        final result = TvImageResponse.fromJson(json.decode(response.body));
        responseCache.set("tv_show_images_$id", result);
        return result;
      } else {
        throw Exception("Some error occured while loading Tv Show Images");
      }
    }
  }

  //Method to list all casts of a movie
  Future<TvShowCastResponse> fetchTvShowCasts(String id) async {
    if (responseCache.contains("casts_$id")) {
      return responseCache.get("casts_$id");
    } else {
      final response =
          await http.get("$BASE_URL$TV_URL$id/credits?api_key=$TMDB_API_KEY");

      if (response.statusCode == 200) {
        final result = TvShowCastResponse.fromJson(json.decode(response.body));
        responseCache.set("casts_$id", result);
        return result;
      } else {
        throw Exception("Movie cast not Loaded");
      }
    }
  }

  /*
   *
   *  Celeb APIs - All APIs related to Persons
   *  
   */

  //Method to fetch list of Celebrities [Most Popular]
  Future<CelebResponseModel> fetchCelebrities(String type, int page) async {
    if (responseCache.contains("celebs_$type$page")) {
      return responseCache.get("celebs_$type$page");
    } else {
      final response = await http
          .get("$BASE_URL$CELEB_URL$type?api_key=$TMDB_API_KEY&page=$page");

      if (response.statusCode == 200) {
        final result = CelebResponseModel.fromJson(json.decode(response.body));
        responseCache.set("celebs_$type$page", result);
        return result;
      } else {
        throw Exception("Celebrity not loaded");
      }
    }
  }

  //Method to load details of a person by id
  Future<CelebDetailsResponse> fetchCelebDetails(String id) async {
    if (responseCache.contains("celebs_$id")) {
      return responseCache.get("celebs_$id");
    } else {
      final response =
          await http.get("$BASE_URL$CELEB_URL$id?api_key=$TMDB_API_KEY");

      if (response.statusCode == 200) {
        final result =
            CelebDetailsResponse.fromJson(json.decode(response.body));
        responseCache.set("celebs_$id", result);
        return result;
      } else {
        throw Exception("Celebrity Details not found");
      }
    }
  }

  //Method to list all images of a person
  Future<CelebImagesResponse> fetchCelebImages(String id) async {
    if (responseCache.contains("celeb_images_$id")) {
      return responseCache.get("celeb_images_$id");
    } else {
      final response =
          await http.get("$BASE_URL$CELEB_URL$id/images?api_key=$TMDB_API_KEY");

      if (response.statusCode == 200) {
        final result = CelebImagesResponse.fromJson(json.decode(response.body));
        responseCache.set("celeb_images_$id", result);
        return result;
      } else {
        throw Exception("Some error occured while loading Celeb Images");
      }
    }
  }

//Method to list all movies of a celeb
  Future<CelebMoviesResponse> fetchCelebMovies(String id) async {
    if (responseCache.contains("celeb_movies_$id")) {
      return responseCache.get("celeb_movies_$id");
    } else {
      final response = await http
          .get("$BASE_URL$CELEB_URL$id/movie_credits?api_key=$TMDB_API_KEY");

      if (response.statusCode == 200) {
        final result = CelebMoviesResponse.fromJson(json.decode(response.body));
        responseCache.set("images_$id", result);
        return result;
      } else {
        throw Exception("Some error occured while loading Celeb Movies");
      }
    }
  }

//Method to list all tv shows of a celeb
  Future<CelebTvShowsResponse> fetchTvShows(String id) async {
    if (responseCache.contains("celeb_tv_shows_$id")) {
      return responseCache.get("celeb_tv_shows_$id");
    } else {
      final response = await http
          .get("$BASE_URL$CELEB_URL$id/tv_credits?api_key=$TMDB_API_KEY");

      if (response.statusCode == 200) {
        final result =
            CelebTvShowsResponse.fromJson(json.decode(response.body));
        responseCache.set("images_$id", result);
        return result;
      } else {
        throw Exception("Some error occured while loading Celeb Movies");
      }
    }
  }

/*
 *
 *  Search APIs - All APIs related to movies
 *  
 */

  Future<SearchResponse> search(String query, int page) async {
    if (responseCache.contains(query)) {
      return responseCache.get(query);
    } else {
      final response = await http.get(
          "$BASE_URL$SEARCH_URL?api_key=$TMDB_API_KEY&query=$query&page=$page");
      if (response.statusCode == 200) {
        final result = SearchResponse.fromJson(json.decode(response.body));
        responseCache.set(query, result);
        return result;
      } else {
        throw Exception(
            "Sorry, but we could'nt find anything! Please try another search term.");
      }
    }
  }
}
