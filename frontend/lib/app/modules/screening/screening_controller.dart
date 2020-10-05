import 'package:frontend/app/data/models/screening_model.dart';
import 'package:frontend/app/services/screening_service.dart';
import 'package:get/get.dart';

class UserController extends GetxController {

  final RxBool _loading = true.obs;
  get loading => this._loading.value;
  set loading(value) => this._loading.value = value;

  List<ScreeningModel> _screening = [];
  List<ScreeningModel> get screening => _screening;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    this.loadScreenings();
  }

  Future<void> loadScreenings() async  {
    final data = await ScreeningService.instance.getScreenings();
    this._screening = data;
    loading = false;
    update();
  }
}