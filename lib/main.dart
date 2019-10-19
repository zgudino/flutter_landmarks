import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:landmarks_flutter/constants.dart';
import 'package:landmarks_flutter/models/data.dart';
import 'package:landmarks_flutter/views/landmark_detail.dart';
import 'package:landmarks_flutter/widgets/landmark_cell.dart';

void main() {
  landmarksData().then((_) {
    runApp(LandmarksApp());
  });
}

class LandmarksApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Landmarks',
      theme: ThemeData(primaryColor: Colors.blueAccent),
      home: Home(title: 'Landmarks'),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _showFavoritesOnly = false;

  @override
  Widget build(BuildContext context) {
    final landmarks = _showFavoritesOnly ? favoriteLandmarks : allLandmarks;

    return Material(
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              centerTitle: true,
              title: Text(widget.title),
              pinned: true,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: Constants.defaultHorizontalPadding / 4,
                  horizontal: Constants.defaultHorizontalPadding,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Mostrar solo favoritos',
                      style: TextStyle().copyWith(
                        fontSize: 17.0,
                      ),
                    ),
                    Switch(
                      value: _showFavoritesOnly,
                      onChanged: (state) {
                        setState(() {
                          _showFavoritesOnly = state;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: const Divider(
                height: 1,
                indent: Constants.defaultHorizontalPadding,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final landmark = landmarks[index];
                  return LandmarkCell(
                    landmark: landmark,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LandmarkDetail(
                            landmark: landmark,
                            title: widget.title,
                          ),
                        ),
                      );
                    },
                  );
                },
                childCount: landmarks.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
