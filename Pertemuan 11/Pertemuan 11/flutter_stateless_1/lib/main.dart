import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stateless_1/widgets/result.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Konverter Suhu'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controllerCelcius = TextEditingController();
  //variabel berubah
  double _inputCelcius = 0;
  double _kelvin = 0;
  //tambahkan variabel lain yang dibutuhkan
  double _reamur = 0;

  konverterSuhu() {
    setState(() {
      if (_controllerCelcius.text.isNotEmpty) {
        _inputCelcius = double.parse(_controllerCelcius.text);
        _kelvin = _inputCelcius + 273.15;
        _reamur = _inputCelcius * 0.8;
      }
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _controllerCelcius.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        margin: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                hintText: ("Masukkan Suhu Dalam Celcius"), //hint text
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              controller: _controllerCelcius,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: ResultKonversi(
                    result: _kelvin,
                    jenis: 'Kelvin',
                  ),
                ),
                Expanded(
                  child: ResultKonversi(
                    result: _reamur,
                    jenis: 'Reamur',
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      konverterSuhu();
                    },
                    child: const Text("Konversi Suhu"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
