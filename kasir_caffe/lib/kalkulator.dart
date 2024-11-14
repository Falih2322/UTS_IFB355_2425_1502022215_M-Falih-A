import 'package:flutter/material.dart';

class MathPage extends StatefulWidget {
  const MathPage({super.key});

  @override
  _MathPageState createState() => _MathPageState();
}

class _MathPageState extends State<MathPage> {
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _moneyController = TextEditingController();

  double _result = 0;
  double _bmiResult = 0;
  double _convertedMoney = 0;

  // Konstanta untuk konversi mata uang (misalnya 1 USD = 15,000 IDR)
  final double _usdToIdrRate = 15000.0;

  // Fungsi perhitungan kuadrat
  void _calculateSquare() {
    final input = double.tryParse(_inputController.text);
    if (input != null) {
      setState(() {
        _result = input * input;
      });
    }
  }

  // Fungsi perhitungan BMI
  void _calculateBMI() {
    final weight = double.tryParse(_weightController.text);
    final heightCm = double.tryParse(_heightController.text);

    // Validasi input
    if (weight != null && weight > 0 && heightCm != null && heightCm > 0) {
      setState(() {
        // Mengonversi tinggi badan dari cm ke meter (dibagi 100) dan kemudian menghitung BMI
        double heightM = heightCm / 100; // Mengubah cm ke meter
        _bmiResult = weight / (heightM * heightM); // Rumus BMI
      });
    } else {
      // Tampilkan pesan error jika input tidak valid
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Tolong masukkan nilai yang valid untuk berat badan dan tinggi badan')),
      );
    }
  }

  // Fungsi konversi uang
  void _convertMoney() {
    final amount = double.tryParse(_moneyController.text);
    if (amount != null) {
      setState(() {
        _convertedMoney = amount / _usdToIdrRate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Matematika'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.popUntil(context, ModalRoute.withName('/dashboard'));
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Perhitungan Persegi
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Perhitungan Persegi',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _inputController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Masukkan Angka',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _calculateSquare,
                      child: const Text('Hitung Kuadrat'),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Hasil: $_result',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),

            // Perhitungan BMI
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Perhitungan BMI (kg, cm)',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _weightController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Berat Badan (kg)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _heightController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Tinggi Badan (cm)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _calculateBMI,
                      child: const Text('Hitung BMI'),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Hasil BMI: ${_bmiResult.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),

            // Konversi Uang
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Konversi Uang (IDR ke USD)',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _moneyController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Jumlah Uang dalam IDR',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _convertMoney,
                      child: const Text('Konversi ke USD'),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Hasil Konversi: \$${_convertedMoney.toStringAsFixed(2)} USD',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
