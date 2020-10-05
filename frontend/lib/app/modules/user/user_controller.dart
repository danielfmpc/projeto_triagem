import 'package:frontend/app/data/models/user_model.dart';
import 'package:frontend/app/services/user_service.dart';
import 'package:get/get.dart';

class UserController extends GetxController {

  final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;

  final RxBool _loading = true.obs;
  get loading => this._loading.value;
  set loading(value) => this._loading.value = value;
  

  List<UserModel> _user = [];
  List<UserModel> get user => _user;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    this.loadUsers();
  }

  Future<void> loadUsers() async  {
    final data = await UserService.instance.getUsers();
    this._user = data;
    loading = false;
    update();
  }
}
