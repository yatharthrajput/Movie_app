import 'package:flutter/material.dart';
import 'package:the_movie_app/models/category_model.dart';

class HomePageHeader extends StatefulWidget {
  final void Function(int) onTap;
  final int selectedTab;

  HomePageHeader({this.selectedTab, this.onTap});

  @override
  _HomePageHeaderState createState() => _HomePageHeaderState();
}

class _HomePageHeaderState extends State<HomePageHeader>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    tabController = new TabController(
        length: 4, initialIndex: widget.selectedTab, vsync: this);
  }

  List<Widget> getTabs() {
    return categoryList.map((category) {
      return Container(
        height: 40,
        width: 160.0,
        margin: const EdgeInsets.only(left: 16, bottom: 16),
        child: Center(
          child: Text(
            category.label,
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [category.startColor, category.endColor]),
            borderRadius: new BorderRadius.all(new Radius.circular(8.0)),
            color: Colors.white),
        padding: new EdgeInsets.only(left: 16, right: 16),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    tabController.animateTo(widget.selectedTab);
    return Container(
      width: double.infinity,
      height: 240,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            "images/banner.png",
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 70,
            left: 25,
            right: 25,
            bottom: 90,
            child: Container(
              height: 50,
              margin: const EdgeInsets.fromLTRB(8, 25, 8, 4),
              child: Center(
                child: TextField(
                  style: TextStyle(color: Colors.black, fontSize: 18.0),
                  controller: _controller,
                  textAlign: TextAlign.start,
                  onSubmitted: (query) =>
                      Navigator.pushNamed(context, "/search/$query"),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      alignLabelWithHint: true,
                      suffixIcon: Icon(
                        Icons.search,
                        size: 22,
                        color: Colors.grey[600],
                      ),
                      hintText: "Search for movies,tv shows...",
                      hintStyle:
                          TextStyle(color: Colors.grey[600], fontSize: 16.0)),
                ),
              ),
              decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.all(new Radius.circular(25.0)),
                  color: Colors.white),
              padding: new EdgeInsets.only(left: 16, right: 8, top: 4),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: TabBar(
              isScrollable: true,
              indicatorColor: Colors.deepPurple,
              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(color: Colors.deepPurple, width: 2.0)),
              tabs: getTabs(),
              onTap: widget.onTap,
              controller: tabController,
            ),
          )
        ],
      ),
    );
  }
}
