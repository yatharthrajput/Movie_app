import 'package:bloc/bloc.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:the_movie_app/bloc/simple_bloc_delegate.dart';
import 'package:the_movie_app/repository/cache_response_provider.dart';
import 'package:the_movie_app/repository/movie_api_provider.dart';
import 'package:the_movie_app/repository/repository.dart';
import 'package:the_movie_app/routes.dart';
import 'package:the_movie_app/screens/home/home_page.dart';
import 'package:the_movie_app/utils/constants.dart';

void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

@immutable
class MyApp extends StatelessWidget {
  final CacheProvider responseCache = CacheProvider();
  MoviesApiProvider _apiProvider;
  Repository _repository;

  MyApp() {
    _apiProvider = MoviesApiProvider(responseCache);
    _repository = Repository(_apiProvider);
  }

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) => ThemeData(
          primaryColorDark: Colors.deepPurple,
          primarySwatch: Colors.deepPurple,
          brightness: brightness,
          textTheme: TextTheme(
            headline: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Constants.textColor(brightness)),
            subhead: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
                color: Colors.deepPurpleAccent),
          )),
      themedWidgetBuilder: (context, theme) {
        return MaterialApp(
          title: 'The Movie Database',
          debugShowCheckedModeBanner: false,
          darkTheme: ThemeData.dark(),
          theme: theme,
          home: HomePage(repository: _repository),
          onGenerateRoute:
              Routes(repository: _repository).generateRoute().generator,
        );
      },
    );
  }
}
