import 'package:database_sqlite/ui/uidetail.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:database_sqlite/helpers/dbhelper.dart';
import 'package:database_sqlite/ui/uientryform.dart';
import 'package:database_sqlite/models/item.dart';

//pendukung program asinkron

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DbHelper db = DbHelper();
  int count = 0;
  List<Item> listItem = [];

  @override
  void initState() {
    _getAllItem();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Item'),
        backgroundColor: const Color.fromARGB(255, 86, 95, 115),
      ),
      body: ListView.builder(
          itemCount: listItem.length,
          itemBuilder: (context, index) {
            Item item = listItem[index];

            return ListTile(
              onTap: () {
                //edit
                _openFormEdit(item);
              },
              contentPadding: const EdgeInsets.all(16),
              title: Text(
                '${item.name}',
                style: const TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    color: Color.fromARGB(255, 0, 0, 0)),
              ),
              subtitle: Text('${item.price}'),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  AlertDialog hapus = AlertDialog(
                    title: const Text('Peringatan'),
                    content: SizedBox(
                      height: 100,
                      child: Column(
                        children: [
                          Text('Apakah ingin menghapus data ${item.name}'),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: const Text('Ya'),
                        onPressed: () {
                          //delete
                          _deleteItem(item, index);
                          Navigator.pop(context);
                        },
                      ),
                      TextButton(
                        child: const Text('Tidak'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                  showDialog(context: context, builder: (context) => hapus);
                },
              ),
              leading: IconButton(
                onPressed: () {
                  //detail
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailPage(item)));
                },                
                color: Colors.red,
                icon: const Icon(Icons.remove_red_eye_rounded),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 86, 95, 115),
        onPressed: () {
          //add
          _openFormCreate();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _getAllItem() async {
    var list = await db.getAllItem();
    setState(() {
      listItem.clear();
      for (var item in list!) {
        listItem.add(Item.fromMap(item));
      }
    });
  }

  Future<void> _deleteItem(Item item, int position) async {
    await db.deleteItem(item.id!);

    setState(() {
      listItem.removeAt(position);
    });
  }

  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const FormItem()));
    if (result == 'save') {
      await _getAllItem();
    }
  }

  Future<void> _openFormEdit(Item item) async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => FormItem(item: item)));
    if (result == 'update') {
      await _getAllItem();
    }
  }
}
