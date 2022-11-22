import 'package:flutter/material.dart';
import 'package:belanja/models/item.dart';

class ItemPage extends StatelessWidget {
  const ItemPage({super.key});

  
  @override
  Widget build(BuildContext context) {
    final itemArgs = ModalRoute.of(context)!.settings.arguments as Item;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping List Item"),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Name : ${itemArgs.name}'),
          ),
          ListTile(
            title: Text('Price : ${itemArgs.price}'),
          ),
          ListTile(
            title: Text('Quantity : ${itemArgs.quantity}'),
          ),
          ListTile(
            title: Text('Total : ${itemArgs.totalPrice} = ${itemArgs.price * itemArgs.quantity}'),
          ),

        ]
      ),
    );
  }
}
