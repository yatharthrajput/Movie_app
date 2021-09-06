import 'package:flutter/material.dart';

class Constants {

  static const String POPULAR_MOVIES = "popular";
  static const String TOP_RATED_MOVIES = "top_rated";
  static const String NOW_PLAYING_MOVIES = "now_playing";
  static const String UPCOMING_MOVIES = "upcoming";
  static const String AIRING_TODAY = "airing_today";
  static const String ON_THE_AIR = "on_the_air";



  static Color textColor(Brightness brightness) =>
      brightness == Brightness.light ? Colors.black : Colors.white;
}

enum ViewEvent { MOVIE, TV, CELEBS }
