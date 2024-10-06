import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/shop_page_controller.dart';
import '../../widgets/product_card.dart';
import '../../widgets/search_widget.dart';
import 'filters.dart';

class ShopPage extends StatefulWidget {
  final PageController? pageController;

  const ShopPage({super.key, this.pageController});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final ShopPageController shopController = Get.put(ShopPageController());
  final ScrollController _scrollController = ScrollController();
  bool isFiltering = false;

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        if (!shopController.isFiltered.value) {
          shopController.loadMoreProducts();
        }
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
                Row(
                  children: [
                    const Expanded(flex: 5, child: SearchWidget()),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        child: Obx(() => Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Image.asset(
                            shopController.isFiltered.value
                                ? 'assets/images/cancel_icon.png' // Display cancel icon when filtered
                                : 'assets/images/filter_icon.png', // Display filter icon when not filtered
                            height: 20,
                          ),
                        )),
                        onTap: () {
                          if (shopController.isFiltered.value) {
                            // Call reset when icon is cancel
                            shopController.resetFiltersAndFetch();
                          } else {
                            // Open filter modal when icon is filter
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return const FractionallySizedBox(
                                  heightFactor: 2 / 3,
                                  child: Filters(),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),

                Expanded(
                  child: Obx(
                        () {
                      if (shopController.isLoading.value && shopController.filteredProductList.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (shopController.filteredProductList.isEmpty) {
                        return const Center(child: Text('No products available'));
                      } else {
                        return RefreshIndicator(
                          onRefresh: () async {
                            shopController.refreshProducts();
                          },
                          child: GridView.builder(
                            controller: _scrollController,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // Define two columns
                              crossAxisSpacing: 10, // Space between columns
                              mainAxisSpacing: 10, // Space between rows
                              childAspectRatio: 2 / 3, // Adjust as needed for aspect ratio
                            ),
                            itemCount: shopController.filteredProductList.length,
                            itemBuilder: (context, index) {
                              return productCard(
                                shopController.filteredProductList[index],
                                context,
                              );
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
