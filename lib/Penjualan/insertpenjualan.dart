import 'package:flutter/material.dart';
import 'package:ukk_2025/homepage.dart';
import 'package:ukk_2025/penjualan/indexpenjualan.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddTransaksi extends StatefulWidget {
  const AddTransaksi({super.key});

  @override
  State<AddTransaksi> createState() => _AddTransaksiState();
}

class _AddTransaksiState extends State<AddTransaksi> {
  final _tgl = TextEditingController();
  final _hrg = TextEditingController();
  final _pelanggan = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> transaksi() async {
    if (_formKey.currentState!.validate()) {
      final String tanggalPenjualan = _tgl.text;
      final double totalHarga = double.tryParse(_hrg.text) ?? 0;
      final int pelangganid = int.tryParse(_pelanggan.text) ?? 0;

      try {
        final response = await Supabase.instance.client.from('penjualan').insert({
          'tanggalpenjualan': tanggalPenjualan, 
          'totalharga': totalHarga,
          'pelangganid': pelangganid,
        });

        if (response.error == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Transaksi berhasil ditambahkan')),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AddTransaksi()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal menambahkan transaksi: ${response.error?.message}')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Terjadi kesalahan: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Penjualan')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _tgl,
                decoration: const InputDecoration(
                  labelText: 'Tanggal Penjualan (YYYY-MM-DD)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tanggal tidak boleh kosong';
                  }
                  // Pastikan format tanggal benar
                  final RegExp dateRegex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
                  if (!dateRegex.hasMatch(value)) {
                    return 'Format tanggal harus YYYY-MM-DD';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _hrg,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Harga Penjualan',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Harga tidak boleh kosong';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Masukkan angka yang valid';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _pelanggan,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Pelanggan ID',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Pelanggan ID tidak boleh kosong';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Masukkan angka yang valid';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                  onPressed: transaksi,
                  child: const Text('Tambah', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
