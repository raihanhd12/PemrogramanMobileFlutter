class Item {
  int? id;
  String? name;
  String? price;

  // Konstruktor Versi 1
  Item({this.id, this.name, this.price});

  // Konstruktor versi 2: konversi dari Item ke Map

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    if (id != null) {
      map['id'] = id;
    }
    map['name'] = name;
    map['price'] = price;
    return map;
  }

  // Konstruktor versi 3: konversi dari Map ke Item
  Item.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    price = map['price'];
  }
}