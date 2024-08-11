import 'package:get/get.dart';

import '../controllers/home_controller.dart';
class RootBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(), fenix: true);
    // Get.lazyPut(() => SplashController(), fenix: true);
    // Get.lazyPut(() => FeedController(), fenix: true);
    // Get.lazyPut(() => SearchesController(), fenix: true);
    // Get.lazyPut(() => UploadController(), fenix: true);
    // Get.lazyPut(() => LikesController(), fenix: true);
    // Get.lazyPut(() => ProfileController(), fenix: true);
    // Get.lazyPut(() => SignUpController(), fenix: true);
    // Get.lazyPut(() => SignInController(), fenix: true);
  }
}