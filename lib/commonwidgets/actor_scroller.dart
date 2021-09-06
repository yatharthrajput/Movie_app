import 'package:flutter/material.dart';
import 'package:the_movie_app/models/common/cast.dart';
import 'package:the_movie_app/utils/constants.dart';
import 'package:the_movie_app/utils/url_provider.dart';

class ActorScroller extends StatelessWidget {
  ActorScroller({this.casts, this.onTap});

  final List<Cast> casts;
  final Function(int id) onTap;

  Widget _buildActor(BuildContext ctx, int index, List<Cast> movieCastList) {
    var actor = movieCastList[index];

    return GestureDetector(
      onTap: () => onTap(actor.id),
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: actor.profilePath != null
                  ? NetworkImage("$IMAGE_BASE_URL${actor.profilePath}")
                  : AssetImage("images/user.png"),
              radius: 40.0,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(actor.name),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Actors',
            style: TextStyle(
              color: Constants.textColor(theme.brightness),
              fontWeight: FontWeight.w500,
              fontSize: 18.0,
            ),
          ),
        ),
        SizedBox.fromSize(
          size: const Size.fromHeight(120.0),
          child: ListView.builder(
            itemCount: casts.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(top: 12.0, left: 20.0),
            itemBuilder: (context, index) => _buildActor(context, index, casts),
          ),
        ),
      ],
    );
  }
}
