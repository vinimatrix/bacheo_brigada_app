import 'dart:convert';

import 'package:bacheo_brigada/helpers/helper_methods.dart';
import 'package:bacheo_brigada/models/reporte.dart';
import 'package:bacheo_brigada/providers/globals.dart';
import 'package:bacheo_brigada/screens/gretings.dart';
import 'package:bacheo_brigada/screens/login.dart';
import 'package:bacheo_brigada/services/http_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStateProvider extends ChangeNotifier {
  double lat = 0.0;
  double lng = 0.0;
  Location location = Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  MapController _mapController = new MapController();
  Reporte? reporte;
  late String _brigada_feedback;
  late String _referencia;
  late String _status;
  late int _userId;

  late int _reporteId;

  List<String> paths = [];
  String get brigada_feedback => _brigada_feedback;
  String get referencia => _referencia;
  String get status => _status;
  int get userId => _userId;
  // ignore: recursive_getters
  int get reporteId => _reporteId;
  MapController get mapController => _mapController;
  set mapController(MapController value) {
    _mapController = value;
  }

  set brigada_feedback(String value) {
    _brigada_feedback = value;
    notifyListeners();
  }

  set status(String value) {
    _status = value;
    notifyListeners();
  }

  set reporteId(int value) {
    _reporteId = value;
    notifyListeners();
  }

  set referencia(String value) {
    _referencia = value;
    notifyListeners();
  }

  set userId(int value) {
    _userId = value;
    notifyListeners();
  }

  set addToPath(String value) {
    paths.add(value);
    notifyListeners();
  }

  AppStateProvider() {
    initialize();
  }

  void initialize() async {
    {
      referencia = '';
      status = '';
      brigada_feedback = '';
      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      location.onLocationChanged.listen((LocationData currentLocation) {
        lat = currentLocation.latitude!;
        lng = currentLocation.longitude!;
      });
      //location.enableBackgroundMode();
    }
  }

  void setLoading(bool bool) {}

  Future<void> logout(BuildContext context) async {
    Globals.user = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  sendMessage(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircularProgressIndicator(),
                  Text('Enviando informe...')
                ],
              ),
            ));
    HelperMethods.sendReport(reporteId, status, brigada_feedback, paths)
        .then((value) {
      int? id = value.id;
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => GrettingsScreen()));
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text("hubo un error"),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Ok'))
                ],
              ));
    });
  }
}
