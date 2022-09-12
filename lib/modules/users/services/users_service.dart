import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

import '../../user_form/data/models/user_model.dart';

class UsersService {
  static const usersAPIUrl = 'https://reqres.in/api/users';
  Future<List<UserModel>> getUsers() async {
    List<UserModel> users = [];
    try {
      var response = await Dio().get(usersAPIUrl);
      List responseBody = response.data['data'];
      users = responseBody.map((user) => UserModel.fromMap(user)).toList();
    } catch (error) {
      debugPrint(error.toString());
    }
    return users;
  }

  Future<UserModel> getUser(int id) async {
    List<UserModel> users = await getUsers();
    UserModel user = users.firstWhere((user) => user.id == id);
    return user;
  }
}
