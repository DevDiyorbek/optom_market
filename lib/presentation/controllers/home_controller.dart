import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  PageController? pageController;
  int currentTap = 0;

  changeCurrentTap(int pageIndex) {
    currentTap = pageIndex;
    update();
  }

  animateToPage(int pageIndex) {
    currentTap = pageIndex;
    pageController!.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
    );
  }
}