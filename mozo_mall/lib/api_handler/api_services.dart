import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mozo_mall/constants/static_consts.dart';

import '../routing/routes.dart';

class ApiService {
  int responseStatusCode = 0;
  // Get api services with token
  Future<dynamic> getwithToken(context, String url) async {
    var storage = const FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    final response = await http.get(Uri.parse(url), headers: {
      'Authorization': "$token",
      "ngrok-skip-browser-warning": "69420",
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
      'Access-Control-Allow-Headers': 'Content-Type, Authorization',
    });

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 401 || response.statusCode == 500) {
      const SnackBar(
        padding: EdgeInsets.all(8.0),
        content: Text(StaticConstants.errMsg),
        backgroundColor: Color.fromARGB(255, 255, 71, 65),
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(5),
      );
      await Navigator.pushNamed(context, Routes.loginScreen);
      await storage.deleteAll();
    } else {
      throw Exception('Failed to load data: ${response.reasonPhrase}');
    }
  }

  // Get api services with headers

  Future<dynamic> getWithHeader(String url) async {
    var storage = const FlutterSecureStorage();
    final response = await http.get(Uri.parse(url), headers: {
      "ngrok-skip-browser-warning": "69420",
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
      'Access-Control-Allow-Headers': 'Content-Type, Authorization',
    });

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.reasonPhrase}');
    }
  }

  // post api with token services
  Future<dynamic> post(context, String url, Map<String, dynamic> data) async {
    var storage = const FlutterSecureStorage();
    String? token = await storage.read(key: 'token');

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "$token",
        "ngrok-skip-browser-warning": "69420",
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
        'Access-Control-Allow-Headers': 'Content-Type, Authorization',
      },
      body: json.encode(data),
    );
    responseStatusCode = response.statusCode;
    print(responseStatusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body);
    } else if (response.statusCode == 401 || response.statusCode == 500) {
      const SnackBar(
        padding: EdgeInsets.all(8.0),
        content: Text(StaticConstants.errMsg),
        backgroundColor: Color.fromARGB(255, 255, 71, 65),
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(5),
      );
      await Navigator.pushNamed(context, Routes.loginScreen);
      await storage.deleteAll();
    } else {
      throw Exception('Failed to post data: ${response.reasonPhrase}');
    }
  }

  // post api with token services
  Future<dynamic> postWithoutHeader(
      context, String url, Map<String, dynamic> data) async {
    var storage = const FlutterSecureStorage();
    String? token = await storage.read(key: 'token');

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "$token",
        "ngrok-skip-browser-warning": "69420",
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
        'Access-Control-Allow-Headers': 'Content-Type, Authorization',
      },
      body: json.encode(data),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body);
    } else if (response.statusCode == 401 || response.statusCode == 500) {
      const SnackBar(
        padding: EdgeInsets.all(8.0),
        content: Text(StaticConstants.errMsg),
        backgroundColor: Color.fromARGB(255, 255, 71, 65),
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(5),
      );
      await Navigator.pushNamed(context, Routes.loginScreen);
      await storage.deleteAll();
    } else {
      throw Exception('Failed to post data: ${response.reasonPhrase}');
    }
  }
}
