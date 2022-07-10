import 'dart:convert';

import 'package:amazon_clone_flutter/constants/error_handling.dart';
import 'package:amazon_clone_flutter/constants/utils.dart';
import 'package:amazon_clone_flutter/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:amazon_clone_flutter/constants/global_varaibles.dart';

class AuthService {
  //sign up user
  void SignupUser(
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
      print(res.statusCode);
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
  }

  void SignInUser({
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
          onSucess: () {
            showSnackBar(
              context,
              "Sucess ! ",
            );
          });
      print(res.body);
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
  }
}
