import 'package:get/get.dart';
import 'package:optom_market/data/datasources/auth_service.dart';
import 'package:optom_market/data/datasources/user_service.dart';
import '../../data/models/user_profile_model.dart';
import '../pages/auth_screens/sign_in_page.dart';

class AccountController extends GetxController {
  var userProfile = Rxn<UserProfile>(); // Use Rxn to handle null cases

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  Future<void> loadUserData() async {
    UserProfile? profile = await UserService().getUserDetails();
    if (profile != null) {
      userProfile.value = profile;
    }
  }

  Future<void> logout() async {
    await AuthService().logout();
    Get.offAll(() => const SignInPage());
  }
}
