import 'package:flutter/material.dart';
import 'package:database_sqlite/models/item.dart';
import 'package:database_sqlite/helpers/dbhelper.dart';

class FormItem extends StatefulWidget {
  final Item? item;

  const FormItem({super.key, this.item});

  @override
  // ignore: library_private_types_in_public_api
  _FormItemState createState() => _FormItemState();
}

class _FormItemState extends State<FormItem> {
  DbHelper db = DbHelper();

  TextEditingController? name;
  TextEditingController? price;

  @override
  void initState() {
    name = TextEditingController(
        text: widget.item == null ? '' : widget.item!.name);
    price = TextEditingController(
        text: widget.item == null ? '' : widget.item!.price);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.item == null ? const Text('Tambah') : const Text('Ubah'),
        backgroundColor: const Color.fromARGB(255, 86, 95, 115),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            // Nama
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: name,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Nama Barang',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
            // Harga
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: price,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Harga',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
            // Tombol Button
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Row(
                children: <Widget>[
                  // Tombol Simpan
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                        backgroundColor: const Color.fromARGB(255, 86, 95, 115),
                      ),
                      child: const Text(
                        'Save',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        if (widget.item == null) {
                          // tambah data
                          insertItem();
                        } else {
                          // ubah data
                          updateItem();
                        }
                      },
                    ),
                  ),
                  Container(
                    width: 5.0,
                  ),
                  // Tombol batal
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                        backgroundColor: const Color.fromARGB(255, 86, 95, 115),
                      ),
                      child: const Text(
                        'Cancel',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> updateItem() async {
      //Update
      await db.updateItem(Item.fromMap({
        'id': widget.item!.id,
        'name': name!.text,
        'price': price!.text,
      }));
      // Kembali ke layar sebelumnya dengan membawa objek itemm
      // ignore: use_build_context_synchronously
      Navigator.pop(context, 'update');
  }

  Future<void> insertItem() async {
    //Insert
    await db.saveItem(Item(
      name: name!.text,
      price: price!.text,
    ));
    // Kembali ke layar sebelumnya dengan membawa objek item
    // ignore: use_build_context_synchronously
    Navigator.pop(context, 'save');
  }
}
