import 'package:bacheo_brigada/providers/globals.dart';
import 'package:bacheo_brigada/services/http_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helpers/helper_methods.dart';
import '../models/user.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;

  late User? _user;
  User? get user => _user;

  AuthProvider() {
    initialize();
  }

  initialize() {
    if (Globals.user == null) {}
    HelperMethods.getUser().then((value) {
      if (value != null) {
        _user = value;
        Globals.user = value;
        _isLoggedIn = true;
        notifyListeners();
      }
    });
  }
}
