import 'package:flutter/material.dart';
import 'package:belanja/models/item.dart';

class ListViewItem extends StatelessWidget {
  const ListViewItem({
    Key? key,
    required this.items,
  }) : super(key: key);

  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/item', arguments: item);
            },
            
            child: Card(
              child: Container(
                margin: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.name)
                        ),
                    Expanded(
                      child: Text(
                        item.price.toString(),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        item.quantity.toString(),
                        textAlign: TextAlign.end,
                    ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}