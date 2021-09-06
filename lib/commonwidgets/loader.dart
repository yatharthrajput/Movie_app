import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.fromSize(
        size: Size.fromWidth(250.0),
        child: Center(
          child: LinearProgressIndicator(),
        ),
      ),
    );
  }
}
