import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:optom_market/presentation/pages/account_page.dart';
import 'package:optom_market/presentation/pages/cart_page.dart';
import 'package:optom_market/presentation/pages/explore_page.dart';
import 'package:optom_market/presentation/pages/shop_page.dart';

import '../controllers/home_controller.dart';
class HomePage extends StatefulWidget {
  static const String id = "home_page";

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    homeController.pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_){
        return Scaffold(
          body: PageView(
            controller: homeController.pageController,
            children: [
              ShopPage(pageController: homeController.pageController),
              ExplorePage(pageController: homeController.pageController),
              const CartPage(),
              const AccountPage(),
            ],
            onPageChanged: (int index) {
              homeController.changeCurrentTap(index);
            },
          ),
          bottomNavigationBar: CupertinoTabBar(
            onTap: (int index) {
              homeController.animateToPage(index);
            },
            currentIndex: homeController.currentTap,
            activeColor: const Color.fromRGBO(193, 53, 132, 1),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 32),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search, size: 32),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart, size: 32),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle, size: 32),
              )
            ],
          ),
        );
      },
    );
  }
}
