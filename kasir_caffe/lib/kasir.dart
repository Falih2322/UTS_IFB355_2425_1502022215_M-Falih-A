import 'package:flutter/material.dart';

class KasirKafePage extends StatefulWidget {
  const KasirKafePage({super.key});

  @override
  _KasirKafePageState createState() => _KasirKafePageState();
}

class _KasirKafePageState extends State<KasirKafePage> {
  final List<MenuItem> menuItems = [
    MenuItem(id: 1, name: 'Kopi Hitam', price: 15000.0),
    MenuItem(id: 2, name: 'Kopi Susu', price: 20000.0),
    MenuItem(id: 3, name: 'Teh Manis', price: 12000.0),
    MenuItem(id: 4, name: 'Kopi Rhum', price: 28000.0),
    MenuItem(id: 5, name: 'Americano', price: 22000.0),
    MenuItem(id: 6, name: 'V60', price: 30000.0),
  ];

  final Transaction transaction = Transaction();
  double selectedDiscount = 0.0;

  void applyPromoCode() {
    setState(() {
      transaction.applyDiscount(selectedDiscount);
    });
  }

  void addToCart(MenuItem item) {
    setState(() {
      transaction.menuItems.add(item);
    });
  }

  void clearCart() {
    setState(() {
      transaction.menuItems.clear();
      selectedDiscount = 0.0; // Reset discount if cart is cleared
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get screen width for responsive design
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kasir Kafe'),
        backgroundColor: Colors.deepOrange,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.popUntil(context, ModalRoute.withName('/dashboard'));
          },
        ),
      ),
      body: SingleChildScrollView(
        // Wrap the entire body in SingleChildScrollView
        padding: EdgeInsets.all(screenWidth * 0.05), // Use relative padding
        child: Column(
          children: [
            // Menu List
            Container(
              padding: EdgeInsets.all(screenWidth * 0.03), // Adjust padding
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Menu Kafe',
                    style: TextStyle(
                      fontSize: 18, // Slightly smaller font for smaller screens
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Use a ListView to fit all items
                  Container(
                    height: screenWidth * 0.6, // Limit the height for menu list
                    child: ListView.builder(
                      itemCount: menuItems.length,
                      itemBuilder: (context, index) {
                        final item = menuItems[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: const Icon(
                              Icons.local_cafe,
                              color: Colors.deepOrange,
                            ),
                            title: Text(item.name),
                            subtitle:
                                Text('Rp. ${item.price.toStringAsFixed(2)}'),
                            trailing: IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () => addToCart(item),
                              color: Colors.deepOrange,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Keranjang / Cart
            Container(
              padding: EdgeInsets.all(screenWidth * 0.03), // Adjust padding
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Keranjang Pesanan',
                    style: TextStyle(
                      fontSize: 18, // Slightly smaller font for smaller screens
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Adjust cart list height to fit better on small screens
                  Container(
                    height: screenWidth * 0.4, // Adjust cart height
                    child: ListView.builder(
                      itemCount: transaction.menuItems.length,
                      itemBuilder: (context, index) {
                        final item = transaction.menuItems[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            title: Text(item.name),
                            subtitle:
                                Text('Rp. ${item.price.toStringAsFixed(2)}'),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Pilih Diskon',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.deepOrange),
                    ),
                    child: DropdownButton<double>(
                      isExpanded: true,
                      value: selectedDiscount,
                      dropdownColor: Colors.white,
                      items: [0, 5, 10, 15]
                          .map((value) => DropdownMenuItem<double>(
                                value: value.toDouble(),
                                child: Text('$value%'),
                              ))
                          .toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedDiscount = newValue!;
                        });
                      },
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 28,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: applyPromoCode,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Terapkan Diskon',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Total: Rp. ${transaction.getTotal().toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: clearCart,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Clear Pemesanan',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Pesanan Dikirim'),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text('Pesanan Anda:'),
                                    const SizedBox(height: 8),
                                    ...transaction.menuItems.map((item) {
                                      return Text(
                                        '${item.name}: Rp. ${item.price.toStringAsFixed(2)}',
                                      );
                                    }),
                                    const SizedBox(height: 8),
                                    Text(
                                        'Diskon: ${selectedDiscount.toStringAsFixed(0)}%'),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Total: Rp. ${transaction.getTotal().toStringAsFixed(2)}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Cetak Pesanan',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Model Classes for Menu and Transaction
class MenuItem {
  final int id;
  final String name;
  final double price;

  MenuItem({
    required this.id,
    required this.name,
    required this.price,
  });
}

class Transaction {
  final List<MenuItem> menuItems = [];
  double discount = 0.0;

  void applyDiscount(double discountPercentage) {
    discount = discountPercentage;
  }

  double getTotal() {
    double total = menuItems.fold(0.0, (sum, item) => sum + item.price);
    return total - (total * discount / 100);
  }
}
