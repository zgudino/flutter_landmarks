import 'package:flutter/material.dart';
import 'package:landmarks_flutter/constants.dart';
import 'package:landmarks_flutter/models/landmark.dart';
import 'package:landmarks_flutter/widgets/star_button.dart';

class LandmarkCell extends StatelessWidget {
  final Landmark landmark;
  final Function() onTap;

  const LandmarkCell({
    Key key,
    @required this.landmark,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Material(
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(
              horizontal: Constants.defaultHorizontalPadding,
              vertical: 2.0,
            ),
            onTap: this.onTap,
            leading: Image.asset(
              'assets/${landmark.imageName}.jpg',
              width: 50.0,
            ),
            title: Text(landmark.name),
            trailing: AnimatedBuilder(
              animation: landmark,
              builder: (context, widget) {
                return landmark.isFavorite
                    ? StarButton(isFavorite: landmark.isFavorite)
                    : SizedBox();
              },
            ),
          ),
        ),
        const Divider(
          height: 1,
          indent: Constants.defaultHorizontalPadding,
        ),
      ],
    );
  }
}
