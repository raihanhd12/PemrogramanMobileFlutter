import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stateless_2/widgets/button.dart';
import 'package:flutter_stateless_2/widgets/dropdown.dart';
import 'package:flutter_stateless_2/widgets/history.dart';
import 'package:flutter_stateless_2/widgets/result.dart';

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
  final _sliderController = TextEditingController();
  //variabel berubah
  double _inputCelcius = 0;
  double _result = 0;
  //tambahkan variabel lain yang dibutuhkan
  var jenisSuhu = ["Kelvin", "Reamur"];
  var selectedSuhu = "Kelvin";
  List<String> history = <String>[];

  setSelectedSuhu(String value) {
    setState(() {
      selectedSuhu = value.toString();
    });
  }

  konverterSuhu() {
    setState(() {
      if (_sliderController.text.isNotEmpty) {
        _inputCelcius = double.parse(_sliderController.text);
        if (selectedSuhu == "Kelvin") {
          _result = _inputCelcius + 273;
        }
        if (selectedSuhu == "Reamur") {
          _result = _inputCelcius * 0.8;
        }

        history.add("$selectedSuhu : $_result");
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
          children: [
            const Text('Slider for integers',
            style: TextStyle(
              fontSize: 15,
              fontStyle: FontStyle.italic
              ),
            ),
            Text(_inputCelcius.toString(),
            style: const TextStyle(
              color: Colors.redAccent
            ),
            ),
            Slider(
              value: _inputCelcius.toDouble(),
              min: 0,
              max: 100,
              divisions: 10,
              label: _inputCelcius.round().toString(),
              thumbColor: Colors.blueAccent,
              onChanged: (double value) {
                setState(() {
                  _inputCelcius = value;
                  _sliderController.text = _inputCelcius.toString();
                });
              },
              onChangeEnd: (double value) {
                setState(() {
                  _inputCelcius = value;
                  _sliderController.text = _inputCelcius.toString();
                  konverterSuhu();
                });
                
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: ("Masukkan Suhu Dalam Celcius (Decimal)"), //hint text
              ),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
              ],
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              controller: _sliderController,
              // readOnly: true,
            ),
            DropdownSuhu(
                jenisSuhu: jenisSuhu,
                selectedSuhu: selectedSuhu,
                setSelectedSuhu: setSelectedSuhu,
                konversi: konverterSuhu),
            ResultKonversi(
              result: _result,
            ),
            ButtonKonversi(konversi: konverterSuhu),
            const Text(
              "Riwayat Konversi",
              style: TextStyle(fontSize: 20),
            ),
            History(history: history)
          ],
        ),
      ),
    );
  }
}
