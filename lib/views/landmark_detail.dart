import 'package:flutter/material.dart';
import 'package:landmarks_flutter/models/landmark.dart';
import 'package:landmarks_flutter/widgets/star_button.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class LandmarkDetail extends StatelessWidget {
  final Landmark landmark;
  final String title;

  LandmarkDetail({
    Key key,
    @required this.landmark,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(title);

    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text("${title ?? ""}"),
        ),
        body: Stack(
          children: <Widget>[
            Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              height: 300.0,
              child: _mapView(),
            ),
            Positioned(
              top: 150.0,
              left: 20.0,
              right: 20.0,
              child: Column(
                children: <Widget>[
                  _imageView(),
                  Padding(padding: const EdgeInsets.only(top: 20.0)),
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          landmark.name,
                          style: TextStyle().copyWith(
                              fontWeight: FontWeight.w400, fontSize: 28.0),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 12.0)),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: AnimatedBuilder(
                          animation: landmark,
                          builder: (context, widget) {
                            return StarButton(
                              isFavorite: landmark.isFavorite,
                              onTap: (value) {
                                landmark.setFavorite(value);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: const EdgeInsets.only(top: 12.0)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        landmark.park,
                        style: TextStyle().copyWith(
                            fontWeight: FontWeight.w500, fontSize: 14.0),
                      ),
                      Expanded(child: Container()),
                      Text(
                        landmark.state,
                        style: TextStyle().copyWith(
                            fontWeight: FontWeight.w500, fontSize: 14.0),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mapView() {
//    return GoogleMap(
//      mapType: MapType.normal,
//      initialCameraPosition: CameraPosition(
//        target: LatLng(
//            landmark.coordinates.latitude, landmark.coordinates.longitude),
//        zoom: 13.70,
//      ),
//      myLocationButtonEnabled: false,
//      onMapCreated: (GoogleMapController controller) {
//        _controller.complete(controller);
//      },
//    );
    return MapboxMap(
        initialCameraPosition: CameraPosition(
      target: LatLng(
        landmark.coordinates.latitude,
        landmark.coordinates.longitude,
      ),
      zoom: 13.70,
    ));
  }

  Widget _imageView() {
    return Container(
      height: 250.0,
      width: double.infinity,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: 4.0,
              color: Colors.transparent,
            ),
            borderRadius: const BorderRadius.all(const Radius.circular(125.0)),
          ),
          width: 250.0,
          height: 250.0,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(const Radius.circular(120.0)),
            child: Image.asset('assets/${landmark.imageName}.jpg'),
          ),
        ),
      ),
    );
  }
}
