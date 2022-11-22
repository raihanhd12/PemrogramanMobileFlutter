import 'package:flutter/material.dart';
import 'package:belanja/models/item.dart';
import 'package:belanja/widgets/listview.dart';

class HomePage extends StatelessWidget {
  
  final List<Item> items = [
    Item(name: 'Sugar', price: 5000, quantity: 3,totalPrice: ''),
    Item(name: 'Salt', price: 2000, quantity: 4,totalPrice: '')
  ];

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping List Home"),
      ),
      body: Container(
        margin: const EdgeInsets.all(8),
        child: ListViewItem(items: items),
      ),
    );
  }
}


