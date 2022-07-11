import 'dart:convert';

import 'package:amazon_clone_flutter/constants/error_handling.dart';
import 'package:amazon_clone_flutter/constants/utils.dart';
import 'package:amazon_clone_flutter/features/auth/home/screens/home_screen.dart';
import 'package:amazon_clone_flutter/models/user.dart';
import 'package:amazon_clone_flutter/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:amazon_clone_flutter/constants/global_varaibles.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  //sign up user
  void signUpUser(
      {required BuildContext context,
      required String email,
      required String password,
      required String name}) async {
    try {
      User user = User(
        id: "",
        name: name.isEmpty ? "" : name,
        email: email.isEmpty ? "" : email,
        password: password.isEmpty ? "" : password,
        address: "",
        type: "",
        token: "",
      );
      http.Response res = await http.post(Uri.parse('$uri/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8"
          });
      httpErrorHandle(
          response: res,
          context: context,
          onSucess: () {
            showSnackBar(
              context,
              "Account is sucessfully crated ! You can now login with the credentials",
            );
          });
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
  }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(Uri.parse('$uri/api/signin'),
          body: jsonEncode({"email": email, "password": password}),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8"
          });
      httpErrorHandle(
          response: res,
          context: context,
          onSucess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await prefs.setString(
                "x-auth-token", jsonDecode(res.body)['token']);
            Navigator.pushNamedAndRemoveUntil(
              context,
              HomeScreen.routeName,
              (route) => false,
            );
            showSnackBar(
              context,
              "Sucess ! ",
            );
          });
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
  }

  // get user data
  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('$uri/api/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
