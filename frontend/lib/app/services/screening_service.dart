import 'package:frontend/app/data/models/screening_model.dart';
import 'package:dio/dio.dart';
import 'package:frontend/app/utils/const_utils.dart';

class ScreeningService{
  ScreeningService._internal();
  static ScreeningService _instance = ScreeningService._internal();
  static ScreeningService get instance => _instance;

  final dio = Dio();

  Future<List<ScreeningModel>> getScreenings() async {
    try {
      final Response response = await dio.get(ConstUtils.BASE_URL_WS +'/screenings');
      // print(response.data);
      return (response.data as List).map((e) => ScreeningModel.fromJson(e)).toList();
    } catch (err) {
      print(err);
      return null;
    }
  }
  
}