import 'package:flutter/material.dart';
import 'package:mozo_mall/api_handler/api_services.dart';
import 'package:mozo_mall/constants/static_urls.dart';

class LoginService {
  final ApiService apiService = ApiService();
  // text editing controllers
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Future<void> login(context) async {
    final userNameController = TextEditingController();
    final passWordController = TextEditingController();
    try {
      Map<String, dynamic> data = {
        "username": userNameController.text,
        "password": passWordController.text
      };
      apiService.postWithoutHeader(context, StaticUrls.auth, data);
    } catch (e) {
      rethrow;
    } finally {}
  }
}
