import 'package:flutter/material.dart';
import 'package:the_movie_app/utils/constants.dart';

class StoryLine extends StatefulWidget {
  final String storyLine;

  StoryLine(this.storyLine);

  _StoryLineState createState() => _StoryLineState();
}

class _StoryLineState extends State<StoryLine> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Story line',
          style: TextStyle(
            color: Constants.textColor(theme.brightness),
            fontWeight: FontWeight.w500,
            fontSize: 18.0,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          widget.storyLine,
          maxLines: isExpanded ? 10 : 2,
          style: TextStyle(
            color: Constants.textColor(theme.brightness),
            fontSize: 16.0,
          ),
        ),
        // No expand-collapse in this tutorial, we just slap the "more"
        // button below the text like in the mockup.
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            InkWell(
              child: Text(
                isExpanded ? 'less' : "more",
                style: textTheme.body1
                    .copyWith(fontSize: 16.0, color: theme.accentColor),
              ),
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
            ),
            Icon(
              isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              size: 18.0,
              color: theme.accentColor,
            ),
          ],
        ),
      ],
    );
  }
}
