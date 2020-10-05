import 'package:frontend/app/data/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:frontend/app/utils/const_utils.dart';

class UserService{
  UserService._internal();
  static UserService _instance = UserService._internal();
  static UserService get instance => _instance;

  final dio = Dio();

  Future<List<UserModel>> getUsers() async {
    try {
      final Response response = await dio.get(ConstUtils.BASE_URL_WS +'/users');
      // print(response.data);
      return (response.data as List).map((e) => UserModel.fromJson(e)).toList();
    } catch (err) {
      print(err);
      return null;
    }
  }
  
}