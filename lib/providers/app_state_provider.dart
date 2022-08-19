import 'dart:convert';

import 'package:bacheo_brigada/constants/colors.dart';
import 'package:bacheo_brigada/helpers/helper_methods.dart';
import 'package:bacheo_brigada/models/reporte.dart';
import 'package:bacheo_brigada/providers/globals.dart';
import 'package:bacheo_brigada/screens/gretings.dart';
import 'package:bacheo_brigada/screens/login.dart';
import 'package:bacheo_brigada/services/http_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:location/location.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/google.dart';
import '../models/notification_info.dart';

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
  late NotificationSettings _settings;
  late int _reporteId;
  List<Reporte> _reportes = [];
  Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
    getReportes();
  }

  late int _totalNotifications;
  PushNotification? _notificationInfo;

  List<Reporte> get reportes => _reportes;
  set reportes(List<Reporte> value) {
    _reportes = value;
    notifyListeners();
  }

  set addTOReportes(Reporte value) {
    _reportes.add(value);
    notifyListeners();
  }

  String? token;
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

  NotificationSettings get settings => _settings;

  set settings(NotificationSettings value) {
    _settings = value;
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
      settings = await fcm.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('User granted permission');
        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
          // Parse the message received
          PushNotification notification = PushNotification(
            title: message.notification?.title,
            body: message.notification?.body,
          );

          _notificationInfo = notification;
          _totalNotifications++;
        });
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        print('User granted provisional permission');
      } else {
        print('User declined or has not accepted permission');
      }

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
          // ...
          if (_notificationInfo != null) {
            // For displaying the notification as an overlay
            showSimpleNotification(
              Text(_notificationInfo!.title!),
              //leading: NotificationBadge(totalNotifications: _totalNotifications),
              subtitle: Text(_notificationInfo!.body!),
              background: brand_colors.ORANGE_MOPC,
              duration: Duration(seconds: 2),
            );
            getReportes();
          }
        });
        token = await fcm.getToken();
        print(token);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token!);

        // Add the following line
        FirebaseMessaging.onBackgroundMessage(
            _firebaseMessagingBackgroundHandler);

        // For handling notification when the app is in background
        // but not terminated
        FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
          PushNotification notification = PushNotification(
            title: message.notification?.title,
            body: message.notification?.body,
          );

          _notificationInfo = notification;
          _totalNotifications++;
          notifyListeners();
        });

        location.onLocationChanged.listen((LocationData currentLocation) {
          lat = currentLocation.latitude!;
          lng = currentLocation.longitude!;
        });
        //location.enableBackgroundMode();
      }
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

  getReportes() {
    if (Globals.user != null) {
      HelperMethods.getUserReportes(Globals.user!.id ?? 0).then((value) => {
            reportes = value,
          });
    }
  }
}
