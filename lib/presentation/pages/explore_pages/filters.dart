import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/filters_page_controller.dart';

class Filters extends StatelessWidget {
  const Filters({super.key});

  @override
  Widget build(BuildContext context) {
    final FiltersController filtersController =
        Get.put(FiltersController()); // Initialize the controller

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Filters'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Get.back(); // Use GetX to go back
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFF2F2F2),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Checkbox to select Egg option
              Obx(() => CheckboxListTile(
                    title: const Text('Eggs'),
                    value: filtersController.isEggsSelected.value,
                    onChanged: (newValue) {
                      filtersController.isEggsSelected.value =
                          newValue ?? false; // Update the selected value
                    },
                  )),
              Obx(() => CheckboxListTile(
                    title: const Text('Noodles & Pasta'),
                    value: filtersController.isNoodlesSelected.value,
                    onChanged: (newValue) {
                      filtersController.isNoodlesSelected.value =
                          newValue ?? false; // Update the selected value
                    },
                  )),

              const Text(
                "Price",
                style: TextStyle(fontSize: 30),
              ),

              // Minimum Price TextField
              Obx(() => TextField(
                    decoration: const InputDecoration(hintText: 'Min Price'),
                    onChanged: (value) {
                      filtersController.minPrice.value =
                          value; // Update min price
                    },
                  )),
              // Maximum Price TextField
              Obx(() => TextField(
                    decoration: const InputDecoration(hintText: 'Max Price'),
                    onChanged: (value) {
                      filtersController.maxPrice.value =
                          value; // Update max price
                    },
                  )),
              // Order by radio buttons
              Obx(() => RadioListTile(
                    title: const Text('Order by name'),
                    value: 'name',
                    groupValue: filtersController.selectedOrderBy.value,
                    // Set to the selected value
                    onChanged: (value) {
                      filtersController.selectedOrderBy.value =
                          value.toString();
                    },
                  )),
              Obx(() => RadioListTile(
                    title: const Text('Order by price'),
                    value: 'price',
                    groupValue: filtersController.selectedOrderBy.value,
                    // Set to the selected value
                    onChanged: (value) {
                      filtersController.selectedOrderBy.value =
                          value.toString();
                    },
                  )),
              // Apply Filter button
              ElevatedButton(
                onPressed: () {
                  filtersController.applyFilters(); // Call apply filters method
                },
                child: const Text('Apply Filter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
