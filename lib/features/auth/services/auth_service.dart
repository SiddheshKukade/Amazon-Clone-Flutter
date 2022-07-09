import 'package:amazon_clone_flutter/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:amazon_clone_flutter/constants/global_varaibles.dart';

class AuthService {
  //sign up user
  void SignupUser(
      {required String email,
      required String password,
      required String name}) async {
    try {
      User user = User(
        id: "",
        name: "",
        email: "",
        password: "",
        address: "",
        type: "",
        token: "",
      );
      http.post(Uri.parse('$uri/api/signup'));
    } catch (e) {}
  }
}
