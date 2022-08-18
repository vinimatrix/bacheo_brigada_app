import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;

class HttpSerrvice {
  static const String baseUrl = 'http://bacheo.oowltechnology.com/api/';

  Future<String> uploadPhotos(List<String> paths, int userId,
      String brigada_feedback, String status, int reporte_id) async {
    Uri uri = Uri.parse('${baseUrl}reports/brigada-update');

    http.MultipartRequest request = http.MultipartRequest('POST', uri);

    request.fields['status'] = status;
    request.fields['brigada'] = userId.toString();
    request.fields['brigada_feedback'] = brigada_feedback;
    request.fields['id'] = reporte_id.toString();

    for (String path in paths) {
      request.files.add(await http.MultipartFile.fromPath('files', path));
    }

    http.StreamedResponse response = await request.send();
    var responseBytes = await response.stream.toBytes();
    var responseString = utf8.decode(responseBytes);
    print('\n\n');
    print('RESPONSE WITH HTTP');
    print(responseString);
    print('\n\n');
    return responseString;
  }

  Future<http.StreamedResponse> updateProfile(int userid, String name,
      String oldName, String email, XFile? photo) async {
    Uri uri = Uri.parse('${baseUrl}user/update-profile');
    http.MultipartRequest request = http.MultipartRequest('POST', uri);
    request.fields['name'] = name;
    request.fields['oldName'] = oldName;
    request.fields['user_id'] = userid.toString();
    request.fields['email'] = email;

    request.files
        .add(await http.MultipartFile.fromPath('files', photo?.path ?? ''));

    http.StreamedResponse response = await request.send();

    return response;
  }

  Future<http.Response> login(String user, String password) async {
    Uri uri = Uri.parse('http://bacheo.oowltechnology.com/auth/brigada/login');
    var response = await http.post(uri, body: {
      'codigo': user.trim(),
      'password': password.trim(),
    });

    return response;
  }

  Future<http.Response> updateToken(int user_id, String token) async {
    Uri uri = Uri.parse('${baseUrl}brigada/update-token');
    var response = await http.post(uri, body: {
      'id': user_id.toString(),
      'token': token.trim(),
    });

    return response;
  }

  Future<http.Response> isInCircunscripcion(
      int circunscripcion, double lat, double lon) async {
    Uri uri = Uri.parse(
        'http://bacheo.oowltechnology.com/api/circunscripcion/is-in-circunscripcion');
    var response = await http.post(uri, body: {
      'circunscripcion': circunscripcion.toString(),
      'lat': lat.toString(),
      'lng': lon.toString()
    });

    return response;
  }

  Future<http.Response> getprofile(int id) async {
    Uri uri = Uri.parse('${baseUrl}brigada/find/${id.toString()}');
    var response = await http.get(uri);

    return response;
  }

  Future<http.Response> getUserReports(int id) async {
    Uri uri = Uri.parse('${baseUrl}reports/find-by-brigada/${id.toString()}');
    var response = await http.get(uri);

    return response;
  }
}
