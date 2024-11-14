import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // Fungsi untuk membuka URL
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.popUntil(context, ModalRoute.withName('/dashboard'));
          },
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Foto Profil dengan efek transisi (Hero)
            Hero(
              tag: 'profile-image',
              child: CircleAvatar(
                radius: 120,
                backgroundImage: AssetImage('assets/falih.jpg'),
              ),
            ),
            const SizedBox(height: 10),

            // Nama dan NRP dalam Card untuk tampilan lebih bersih
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Muhammad Falih Alkautsar',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'NIM: 152022215',
                      style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Kontak Sosial dengan animasi tombol
            _socialButton(
              icon: Icons.card_giftcard_rounded,
              label: 'LinkedIn',
              url: 'https://www.linkedin.com/in/username',
            ),
            _socialButton(
              icon: Icons.camera_alt,
              label: 'Instagram',
              url: 'https://www.instagram.com/falihalka',
            ),
            const SizedBox(height: 20),

            // Tombol Tambahan
            ElevatedButton.icon(
              onPressed: () {
                // Misalnya bisa menampilkan informasi kontak lainnya atau melakukan aksi lain
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Kontak Lainnya'),
                    content: const Text('Email: falih@domain.com'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Tutup'),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.mail),
              label: const Text('Kontak Saya'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk membuat tombol sosial media
  Widget _socialButton(
      {required IconData icon, required String label, required String url}) {
    return GestureDetector(
      onTap: () => _launchURL(url),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.blueAccent),
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
