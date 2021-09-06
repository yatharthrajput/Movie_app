import 'package:flutter/material.dart';
import 'package:the_movie_app/repository/repository.dart';
import 'package:the_movie_app/screens/home/home_page_header.dart';
import 'package:the_movie_app/screens/home/pages/celeb/celebs_page.dart';
import 'package:the_movie_app/screens/home/pages/movie/movie_page.dart';
import 'package:the_movie_app/screens/home/pages/tvshow/tv_show_page.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:dynamic_theme/theme_switcher_widgets.dart';

class HomePage extends StatefulWidget {
  HomePage({@required this.repository});

  final Repository repository;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  PageController _pageController;
  int initialPage = 0;
  int selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: initialPage, keepPage: true);
  }

  void onPageChanged(int value) {
    setState(() {
      this.selectedTab = value;
    });
  }

  void showChooser() {
    showDialog<void>(
        context: context,
        builder: (context) {
          return BrightnessSwitcherDialog(
            onSelectedTheme: (brightness) {
              DynamicTheme.of(context).setBrightness(brightness);
              Navigator.of(context).pop();
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        reverse: false,
        child: Column(
          children: <Widget>[
            HomePageHeader(
              selectedTab: selectedTab,
              onTap: (index) {
                if (index < 3) {
                  _pageController.jumpToPage(index);
                } else {
                  showChooser();
                }
              },
            ),
            SizedBox(
              height: 1300,
              child: PageView(
                pageSnapping: true,
                onPageChanged: onPageChanged,
                controller: _pageController,
                children: <Widget>[
                  MoviePage(repository: widget.repository),
                  TvShowPage(
                    repository: widget.repository,
                  ),
                  CelebsPage(
                    repository: widget.repository,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
