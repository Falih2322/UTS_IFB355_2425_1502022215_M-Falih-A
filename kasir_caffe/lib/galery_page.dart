import 'package:flutter/material.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Galeri Foto Kafe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Dua kolom dalam grid
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount:
              10, // Jumlah gambar, sesuaikan dengan jumlah gambar yang ada
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Tindakan saat foto diklik, misalnya lihat detail atau berbagi
                // Bisa ditambahkan logika di sini jika diinginkan
              },
              child: Card(
                elevation: 4.0,
                child: Image.asset(
                  'assets/gallery/image_$index.jpg', // Menyesuaikan nama file gambar
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Fungsi untuk mengunggah foto baru (akan ditambahkan logika sesuai kebutuhan)
        },
        child: const Icon(Icons.add_a_photo),
        tooltip: 'Unggah Foto',
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Galeri Foto Kafe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GalleryPage(),
    );
  }
}
