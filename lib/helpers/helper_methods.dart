import 'dart:convert';

import 'package:bacheo_brigada/models/reporte.dart';
import 'package:bacheo_brigada/services/http_service.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import '../providers/globals.dart';

class HelperMethods {
  static Future<User?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');
    print(userJson);
    if (userJson == null) {
      return null;
    }
    Map<String, dynamic> userMap = json.decode(userJson);
    User noPicUser = User.fromSharedPreferences(userMap);
    User userWithProfile = await HelperMethods.getProfile(noPicUser.id);
    String? token = prefs.getString('token');
    HelperMethods.UpdateToken(Globals.user?.id ?? 0, token!);
    return userWithProfile;
  }

  static Future<User> setUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? userJson = prefs.getString('user');
    //print(userJson);

    String userJson = prefs.setString("user", jsonEncode(user)) as String;
    Globals.user = user;
    return user;
  }

  static Future<Reporte> sendReport(int reportId, String status,
      String brigada_feedback, List<String> paths) async {
    final HttpSerrvice httpSerrvice = HttpSerrvice();
    var res = await httpSerrvice.uploadPhotos(
        paths, Globals.user?.id ?? 0, brigada_feedback, status, reportId);
    Reporte reporte = Reporte.fromJson(jsonDecode(res));
    if (reporte.id != null) {
      return reporte;
    } else {
      throw "Error enviando Reporte";
    }
  }

  static UpdateToken(int user_id, String token) async {
    HttpSerrvice httpSerrvice = HttpSerrvice();
    var response = await httpSerrvice.updateToken(user_id, token);
    print(response.body);
  }

  static Future<User> getProfile(id) {
    HttpSerrvice httpService = HttpSerrvice();
    return httpService.getprofile(id).then((value) {
      if (value.statusCode == 200) {
        return User.fromJson(jsonDecode(value.body));
      } else {
        throw Exception('Error getting profile');
      }
    });
  }

  static Future<List<Reporte>> getUserReportes(int id) {
    HttpSerrvice httpService = HttpSerrvice();
    return httpService.getUserReports(id).then((value) async {
      if (value.statusCode == 200) {
        var responseString = utf8.decode(value.bodyBytes);

        var userJson = jsonDecode(responseString);
        var list = jsonDecode(value.body).map((data) => Reporte.fromJson(data));
        print(list);
        return List<Reporte>.from(list);
      } else {
        throw Exception('Error getting reports');
      }
    });
  }

  static bool isInCircunscripcion(double lat, double lon) {
    HttpSerrvice httpService = HttpSerrvice();
    bool res = false;

    httpService.isInCircunscripcion(1, lat, lon).then((value) {
      if (value.statusCode == 201) {
        //var res = jsonDecode(value.body);

        value.body == 'true' ? res = true : res = false;
        return res;
      } else {
        throw Exception('Error getting Circunscripcion');
      }
    }).onError((error, stackTrace) async {
      return false;
    });
    return res;
  }

  static saveUser(user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', jsonEncode(user));
    String? token = prefs.getString('token');
    HelperMethods.UpdateToken(Globals.user?.id ?? 0, token!);
  }

  static Future<User> updateProfile(int userid, String name, String oldName,
      String email, XFile? photo) async {
    HttpSerrvice httpService = HttpSerrvice();
    var response =
        await httpService.updateProfile(userid, name, oldName, email, photo);
    if (response.statusCode == 200) {
      var responseBytes = await response.stream.toBytes();
      var responseString = utf8.decode(responseBytes);

      var userJson = jsonDecode(responseString);
      User user = User.fromJson(userJson);
      setUser(user);
      return user;
    } else {
      throw Exception('Error updating profile');
    }
  }
}
