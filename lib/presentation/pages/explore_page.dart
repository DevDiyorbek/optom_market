import 'package:flutter/material.dart';
import 'package:optom_market/data/models/category_model.dart';
import '../../data/datasources/http_service.dart';
import '../widgets/category_card.dart';
import '../widgets/search_widget.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key, PageController? pageController});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  late Future<List<ProductCategoryModel>> _categoryList;

  @override
  void initState() {
    super.initState();
    _categoryList = ApiService().fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
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
                  child: FutureBuilder<List<ProductCategoryModel>>(
                    future: _categoryList,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text('Error loading products'),
                        );
                      } else if (!snapshot.hasData) {
                        return const Center(
                          child: Text('No products available'),
                        );
                      } else {
                        final categoryList = snapshot.data!;
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                          ),
                          itemCount: categoryList.length,
                          itemBuilder: (context, index) {
                            final category = categoryList[index];
                            return categoryCard(category, context);
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
