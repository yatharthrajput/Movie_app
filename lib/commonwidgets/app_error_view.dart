import 'package:flutter/material.dart';

class ApiErrorView extends StatelessWidget {
  ApiErrorView({this.message, this.onTap});

  final String message;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var brightness = theme.brightness;
    return Center(
      child: SizedBox.fromSize(
        size: const Size.fromWidth(250.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: brightness == Brightness.light
                        ? Colors.grey
                        : Colors.white,
                    fontSize: 14.0),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Container(
                  width: 150.0,
                  child: RaisedButton(
                    color: theme.primaryColor,
                    splashColor: theme.accentColor,
                    onPressed: this.onTap,
                    child: Text(
                      "Retry",
                      style: TextStyle(color: Colors.white, fontSize: 14.0),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
