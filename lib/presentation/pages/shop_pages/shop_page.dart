import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:optom_market/presentation/widgets/product_card.dart';
import 'package:optom_market/presentation/widgets/search_widget.dart';

import '../../controllers/shop_page_controller.dart';

class ShopPage extends StatelessWidget {
  final PageController? pageController;
  final ShopPageController shopController = Get.put(ShopPageController());
  final ScrollController _scrollController = ScrollController();

  ShopPage({super.key, this.pageController});

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        shopController.loadMoreProducts();
      }
    });

    return SafeArea(
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8),
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                const SizedBox(height: 30),
                Image.asset('assets/images/logo.png', height: 35),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on),
                      SizedBox(width: 8.0),
                      Text(
                        "Khorezm, Gurlen",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                const SearchWidget(),
                Expanded(
                  child: Obx(
                    () {
                      if (shopController.isLoading.value &&
                          shopController.filteredProductList.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (shopController.filteredProductList.isEmpty) {
                        return const Center(
                            child: Text('No products available'));
                      } else {
                        return RefreshIndicator(
                          onRefresh: () async {
                            shopController.refreshProducts();
                          },
                          child: ListView.builder(
                            controller: _scrollController,
                            itemCount:
                                (shopController.filteredProductList.length / 2).ceil() +
                                    1,
                            itemBuilder: (context, rowIndex) {
                              if (rowIndex <
                                  (shopController.filteredProductList.length / 2)
                                      .ceil()) {
                                final index1 = rowIndex * 2;
                                final index2 = index1 + 1;
                                return Row(
                                  children: [
                                    Expanded(
                                      child: productCard(
                                          shopController.filteredProductList[index1],
                                          context),
                                    ),
                                    if (index2 <
                                        shopController.filteredProductList.length)
                                      Expanded(
                                        child: productCard(
                                            shopController.filteredProductList[index2],
                                            context),
                                      ),
                                  ],
                                );
                              } else {
                                return Obx(() =>
                                    shopController.hasMoreItems.value
                                        ? const Center(
                                            child: CircularProgressIndicator())
                                        : const SizedBox.shrink());
                              }
                            },
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
