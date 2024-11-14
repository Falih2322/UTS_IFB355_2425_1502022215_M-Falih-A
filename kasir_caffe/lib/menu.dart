import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Untuk menggunakan SystemNavigator
import 'package:kasir_caffe/kasir.dart';
import 'package:kasir_caffe/profile.dart';
import 'package:kasir_caffe/kalkulator.dart';
import 'package:kasir_caffe/galery_page.dart';
import 'package:kasir_caffe/review_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Kasir Kafe',
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
        '/gallery': (context) => const GalleryPage(),
        '/reviews': (context) => const ReviewPage(),
      },
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              // Menutup aplikasi
              SystemNavigator.pop();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2, // Jumlah kolom dalam grid
          crossAxisSpacing: 20, // Jarak antar kolom
          mainAxisSpacing: 20, // Jarak antar baris
          children: <Widget>[
            _buildMenuCard(
              context,
              title: 'Kasir Kafe',
              icon: Icons.local_cafe,
              onPressed: () {
                Navigator.pushNamed(context, '/kasir');
              },
            ),
            _buildMenuCard(
              context,
              title: 'Profile',
              icon: Icons.person,
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
            _buildMenuCard(
              context,
              title: 'Matematika',
              icon: Icons.calculate,
              onPressed: () {
                Navigator.pushNamed(context, '/math');
              },
            ),
            _buildMenuCard(
              context,
              title: 'Galeri Foto',
              icon: Icons.photo_album,
              onPressed: () {
                Navigator.pushNamed(context, '/gallery');
              },
            ),
            _buildMenuCard(
              context,
              title: 'Ulasan',
              icon: Icons.rate_review,
              onPressed: () {
                Navigator.pushNamed(context, '/reviews');
              },
            ),
          ],
        ),
      ),
    );
  }

  // Membuat Card Menu
  Widget _buildMenuCard(BuildContext context,
      {required String title,
      required IconData icon,
      required VoidCallback onPressed}) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 50,
                color: Colors.blueAccent,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _slideController;

  @override
  void initState() {
    super.initState();

    // Fade animation controller
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();

    // Scale animation controller
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();

    // Slide animation controller for text and logo
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();

    // Navigate to dashboard after delay
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/dashboard',
        (Route<dynamic> route) => false,
      );
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Define animations
    var fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    ));

    var scaleAnimation = Tween(begin: 0.0, end: 1.5).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeInOut,
    ));

    Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeInOut,
    ));

    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Stack(
        children: [
          // Gradien background animation
          AnimatedContainer(
            duration: const Duration(seconds: 5),
            color: Colors.blueAccent,
            curve: Curves.easeInOut,
            child: Container(),
          ),

          // Logo and Text Animations
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated logo scaling and fading in
                AnimatedBuilder(
                  animation: _scaleController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: scaleAnimation.value,
                      child: AnimatedBuilder(
                        animation: _fadeController,
                        builder: (context, child) {
                          return FadeTransition(
                            opacity: fadeAnimation,
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage('assets/falih.jpg'),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),

                // Animated text slide and fade in
                SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 1),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: _slideController,
                    curve: Curves.easeInOut,
                  )),
                  child: FadeTransition(
                    opacity: fadeAnimation,
                    child: const Text(
                      'Aplikasi Kasir Kafe',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Author info slide and fade
                SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 1),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: _slideController,
                    curve: Curves.easeInOut,
                  )),
                  child: FadeTransition(
                    opacity: fadeAnimation,
                    child: const Text(
                      'Muhammad Falih Alkautsar\n152022215',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
