
import 'package:flutter/material.dart';
import 'package:ukk_2025/homepage.dart';
import 'package:ukk_2025/Pelanggan/indexpelanggan.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddPelanggan extends StatefulWidget {
  const AddPelanggan({super.key});

  @override 
  State<AddPelanggan> createState() => _AddPelangganState();
}

class _AddPelangganState extends State<AddPelanggan> {
  final _nmplg = TextEditingController();
  final _alamat = TextEditingController();
  final _nmtlp = TextEditingController(); // Deklarasi controller
  final _formKey = GlobalKey<FormState>();

  Future<void> pelanggan() async {
    if (_formKey.currentState!.validate()) {
      final namapelanggan = _nmplg.text; // Memperbaiki nama variabel
      final alamat = _alamat.text;
      final nomortelepon = _nmtlp.text;

      final response = await Supabase.instance.client.from('pelanggan').insert(
        {
          'namapelanggan': namapelanggan, 
          'alamat': alamat,
          'nomortelepon': nomortelepon,
        }
      );

      if (response.error == null) { 
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PelangganTab()),
        );
      } else {
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(builder: (context) => PelangganTab()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Pelanggan'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: _nmplg,
                decoration: InputDecoration(
                  labelText: 'Nama Pelanggan',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _alamat,
                decoration: InputDecoration(
                  labelText: 'Alamat',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _nmtlp, 
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Nomor Telepon',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                  onPressed: pelanggan,
                  child: Text('Tambah', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}