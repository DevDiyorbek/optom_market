import 'package:flutter/material.dart';

class Filters extends StatelessWidget {
  const Filters({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Filters'),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            // Handle back button press
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
              // Filter categories (CheckboxListTile widgets)
              CheckboxListTile(
                title: Text('Eggs'),
                value: true, // Set to true for selected category
                onChanged: (newValue) {
                  // Handle category selection
                },
              ),
              CheckboxListTile(
                title: Text('Noodles & Pasta'),
                value: false,
                onChanged: (newValue) {
                  // Handle category selection
                },
              ),

              const Text("Price", style: TextStyle(fontSize: 30),),


              TextField(
                decoration: InputDecoration(hintText: 'dan'),
              ),
              TextField(
                decoration: InputDecoration(hintText: 'gacha'),
              ),
              // Order by radio buttons (RadioListTile widgets)
              RadioListTile(
                title: Text('Order by name'),
                value: 'name',
                groupValue: 'name', // Set to the selected value
                onChanged: (value) {
                  // Handle radio button selection
                },
              ),
              RadioListTile(
                title: Text('Order by price'),
                value: 'price',
                groupValue: 'name', // Set to the selected value
                onChanged: (value) {
                  // Handle radio button selection
                },
              ),
              // Apply Filter button
              ElevatedButton(
                onPressed: () {
                  // Handle Apply Filter button press
                },
                child: Text('Apply Filter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
