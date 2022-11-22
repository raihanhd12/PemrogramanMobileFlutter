import 'package:flutter/material.dart';

class DropdownSuhu extends StatelessWidget {
  final List<String> jenisSuhu;
  final String selectedSuhu;
  final Function setSelectedSuhu;
  final Function konversi;

  const DropdownSuhu(
      {Key? key,
      required this.jenisSuhu,
      required this.setSelectedSuhu,
      required this.selectedSuhu,
      required this.konversi})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      isExpanded: false,
      items: jenisSuhu.map((suhu) {
        return DropdownMenuItem(value: suhu, child: Text(suhu));
      }).toList(),
      value: selectedSuhu,
      onChanged: (value) {
        setSelectedSuhu(value.toString());
        konversi();
      },
    );
  }
}
