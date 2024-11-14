import 'package:flutter/material.dart';
import 'package:kasir_caffe/galery_page.dart'; // Pastikan path-nya benar
import 'package:kasir_caffe/kalkulator.dart';
import 'package:kasir_caffe/kasir.dart';
import 'package:kasir_caffe/menu.dart';
import 'package:kasir_caffe/profile.dart';
import 'package:kasir_caffe/review_page.dart'; // Pastikan path-nya benar

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Sederhana UTS',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/dashboard': (context) => const DashboardPage(),
        '/kasir': (context) => const KasirKafePage(),
        '/profile': (context) => const ProfilePage(),
        '/math': (context) => const MathPage(),
        '/gallery': (context) =>
            const GalleryPage(), // Rute menuju halaman galeri
        '/reviews': (context) =>
            const ReviewPage(), // Rute menuju halaman ulasan
      },
    );
  }
}
