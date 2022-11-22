import 'package:flutter/material.dart';

class ResultKonversi extends StatelessWidget {
  const ResultKonversi({
    Key? key,
    required double result,
    required String jenis,
  })  : _result = result,
        _jenis = jenis,
        super(key: key);

  final double _result;
  final String _jenis;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Suhu dalam $_jenis",
          style: const TextStyle(fontSize: 15),
        ),
        Text(
          "$_result",
          style: const TextStyle(fontSize: 30),
        ),
      ],
    );
  }
}
