import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:the_movie_app/repository/repository.dart';
import 'package:the_movie_app/screens/celebdetails/celeb_details_page.dart';
import 'package:the_movie_app/screens/celeblist/celeb_grid_page.dart';
import 'package:the_movie_app/screens/home/home_page.dart';
import 'package:the_movie_app/screens/moviedetails/movie_details_page.dart';
import 'package:the_movie_app/screens/movielist/movie_grid_page.dart';
import 'package:the_movie_app/screens/search/search_grid_page.dart';
import 'package:the_movie_app/screens/swiper/image_swiper.dart';
import 'package:the_movie_app/screens/tvdetails/tv_details_page.dart';
import 'package:the_movie_app/screens/tvlist/tv_show_grid_page.dart';

class Routes {
  Routes({this.repository});

  final Repository repository;

  Router generateRoute() {
    Router router = new Router();

    //Route for Movie List Page
    router.define('/home', handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          return HomePage(
            repository: repository,
          );
        }));


    //Route for Movie details page
    router.define('/details/:id', handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return MovieDetailsPage(
        id: params["id"][0],
        repository: repository,
      );
    }));

    //Router for Tv Details Page
    router.define("/tvdetails/:id", handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return TvDetailsPage(
        id: params['id'][0],
        repository: repository,
      );
    }));

    router.define('/movielist/:movieType/:title', handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return MovieGridPage(
          title: params["title"][0],
          type: params["movieType"][0],
          repository: repository);
    }));

    router.define('/tvlist/:type/:title', handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return TvShowGridPage(
        type: params["type"][0],
        title: params["title"][0],
        repository: repository,
      );
    }));

    router.define('/celeblist/:type/:title', handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return CelebGridPage(
          type: params["type"][0],
          title: params["title"][0],
          repository: repository);
    }));

    //Router for Tv Details Page
    router.define("/celebdetails/:id", handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return CelebDetailsPage(
        id: params['id'][0],
        repository: repository,
      );
    }));

    //Router for Search Result Page
    router.define("/search/:query", handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return SearchGridPage(
        query: params['query'][0],
        repository: repository,
      );
    }));

    router.define("/swiper/:data/:pos", handler: Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params){
        return ImageSwiper(
          list: params["data"][0],

        );
      }
    ));

    return router;
  }
}
