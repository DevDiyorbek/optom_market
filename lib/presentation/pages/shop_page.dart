import 'package:flutter/material.dart';
import 'package:optom_market/presentation/widgets/product_card.dart';
import 'package:optom_market/presentation/widgets/search_widget.dart';

import '../../data/datasources/http_service.dart';
import '../../data/models/product_list_model.dart';

class ShopPage extends StatefulWidget {
  final PageController? pageController;

  const ShopPage({super.key, this.pageController});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  late Future<ProductListModel> _productList;

  @override
  void initState() {
    super.initState();
    _productList = ApiService().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8),
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Image.asset(
                  'assets/images/logo.png',
                  height: 35,
                ),
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
                  child: FutureBuilder<ProductListModel>(
                    future: _productList,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(
                            child: Text('Error loading products'));
                      } else if (!snapshot.hasData) {
                        return const Center(
                            child: Text('No products available'));
                      } else {
                        final productList = snapshot.data!;
                        // return productCard(productList.items[0], context);

                        return ListView.builder(
                          itemCount: (productList.items.length / 2).ceil(),
                          itemBuilder: (context, rowIndex) {
                            final index1 = rowIndex * 2;
                            final index2 = index1 + 1;
                            return Row(
                              children: [
                                Expanded(
                                  child: productCard(
                                      productList.items[index1], context),
                                ),
                                if (index2 < productList.items.length)
                                  Expanded(
                                    child: productCard(
                                        productList.items[index2], context),
                                  ),
                              ],
                            );
                          },
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
