import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:optom_market/presentation/controllers/shop_page_controller.dart';

class Filters extends StatelessWidget {
  const Filters({super.key});

  @override
  Widget build(BuildContext context) {
    final ShopPageController controller = Get.put(ShopPageController());

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF2F2F2),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Price",
                style:
                TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: TextField(
                      controller: controller.minPriceController,
                      decoration:
                      const InputDecoration(hintText: 'Falon'),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Expanded(
                      flex: 1,
                      child: Text(
                        "dan",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  Expanded(
                    flex: 1,
                    child: TextField(
                      controller: controller.maxPriceController,
                      decoration:
                      const InputDecoration(hintText: 'Falon'),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Expanded(
                      flex: 1,
                      child: Text(
                        "gacha",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Order By",
                style:
                TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Obx(() =>
                  RadioListTile<String>(
                    title: const Text('Order by name'),
                    value: 'name',
                    groupValue: controller.selectedSortBy.value,
                    onChanged: (value) =>
                    controller.selectedSortBy.value = value!,
                  )),
              Obx(() =>
                  RadioListTile<String>(
                    title: const Text('Order by price'),
                    value: 'price',
                    groupValue: controller.selectedSortBy.value,
                    onChanged: (value) =>
                    controller.selectedSortBy.value = value!,
                  )),
              Obx(() =>
                  RadioListTile<String>(
                    title: const Text('Order by id'),
                    value: 'id',
                    groupValue: controller.selectedSortBy.value,
                    onChanged: (value) =>
                    controller.selectedSortBy.value = value!,
                  )),
              const SizedBox(height: 20),
              const Text(
                "Sort Order",
                style:
                TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Obx(() =>
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            controller.selectedSortOrder.value ==
                                'asc'
                                ? Colors.blue
                                : Colors.grey[300],
                            foregroundColor:
                            controller.selectedSortOrder.value ==
                                'asc'
                                ? Colors.white
                                : Colors.black,
                            padding:
                            const EdgeInsets.symmetric(vertical: 12),
                          ),
                          onPressed: () =>
                          controller.selectedSortOrder.value = 'asc',
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.arrow_upward),
                              SizedBox(width: 8),
                              Text('Ascending'),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            controller.selectedSortOrder.value ==
                                'desc'
                                ? Colors.blue
                                : Colors.grey[300],
                            foregroundColor:
                            controller.selectedSortOrder.value ==
                                'desc'
                                ? Colors.white
                                : Colors.black,
                            padding:
                            const EdgeInsets.symmetric(vertical: 12),
                          ),
                          onPressed: () =>
                          controller.selectedSortOrder.value = 'desc',
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.arrow_downward),
                              SizedBox(width: 8),
                              Text('Descending'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
              const SizedBox(height: 50),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.applyFilters,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        'Apply Filter',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
