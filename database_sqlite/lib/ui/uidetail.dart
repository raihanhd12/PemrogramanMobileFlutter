import 'package:flutter/material.dart';
import 'package:database_sqlite/models/item.dart';

class DetailPage extends StatelessWidget {
  final Item? item;

  const DetailPage(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Detail Page'),
          backgroundColor: const Color.fromARGB(255, 86, 95, 115)),
      body: Center(
        child: Column(
          children: [
            Text('Nama Barang : ${item!.name}'),
            Text('Harga : ${item!.price}'),
          ],
        ),
      ),
    );
  }
}
