import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

class MyCarte extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyCarteState();
  }

}

class MyCarteState extends State<MyCarte>{

  //Variables
  Completer<GoogleMapController> controller = Completer();
  LatLng tourEiffel = const LatLng(48.858278, 2.29425);
  LatLng montParnasse = const LatLng(48.842036, 2.322128);
  LatLng leLouvre = const LatLng(48.861013, 2.33585);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}