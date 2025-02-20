import 'package:flutter/material.dart';
import 'package:ukk_2025/main.dart';  
import 'package:ukk_2025/Pelanggan/indexpelanggan.dart';
import 'package:ukk_2025/Penjualan/indexpenjualan.dart';
import 'package:ukk_2025/Produk/indexproduk.dart';

void main() {
  runApp(Login()); 
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int int_selectedIndex = 0;

  final List<Widget> _pages = [
    Center(
      child: Text(
        'Selamat datang admin',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    ),
    PelanganTab(),
    PenjualanTab(),
    ProdukTab(),
  ];

  final List<String> _titles = [
    'Halaman Produk',
    'Halaman Pelanggan',
    'Halaman Penjualan',
    'Halaman Detail Penjualan'
  ];

  void _onTabTapped(int index) {
    setState(() {
      int_selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[int_selectedIndex]),
        centerTitle: true,
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.purple,
              ),
              child: Text(
                "Menu",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('User'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: int_selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.purple[50],
        currentIndex: int_selectedIndex,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        onTap: _onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Produk',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Pelanggan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Penjualan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Detail Penjualan',
          ),
        ],
      ),
    );
  }
}

class PelanganTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Tab Pelanggan',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class ProdukTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Tab Produk',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class PenjualanTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Tab Penjualan',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
