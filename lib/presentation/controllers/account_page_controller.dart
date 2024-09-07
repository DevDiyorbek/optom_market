import 'package:get/get.dart';
import 'package:optom_market/data/datasources/auth_service.dart';
import '../../../utility/secure_storage.dart';
import '../pages/auth_screens/sign_in_page.dart';

class AccountController extends GetxController {
  var userData = <String, String?>{}.obs;
  final SecureStorage _secureStorage = SecureStorage();

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  Future<void> loadUserData() async {
    userData.value = await _secureStorage.readUserData();
  }

  Future<void> logout() async {
    await AuthService().logout();
    Get.offAll(() => const SignInPage());
  }
}
