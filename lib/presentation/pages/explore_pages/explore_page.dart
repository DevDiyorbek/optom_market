import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/category_card.dart';
import '../../widgets/search_widget.dart';
import '../../controllers/explore_page_controller.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key, this.pageController});
  final PageController? pageController;

  @override
  Widget build(BuildContext context) {
    final ExplorePageController exploreController =
        Get.put(ExplorePageController()); // Initialize the controller

    return SafeArea(
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 14.0,
            vertical: 8,
          ),
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text(
                    "Find Products",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SearchWidget(),
                Expanded(
                  child: Obx(() {
                    if (exploreController.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (exploreController.categoryList.isEmpty) {
                      return const Center(
                        child: Text('No products available'),
                      );
                    } else {
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                        itemCount: exploreController.categoryList.length,
                        itemBuilder: (context, index) {
                          final category =
                              exploreController.categoryList[index];
                          return categoryCard(category, context);
                        },
                      );
                    }
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
