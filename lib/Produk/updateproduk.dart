import 'package:flutter/material.dart';
import 'package:ukk_2025/Produk/insertproduk.dart';
import 'package:ukk_2025/homepage.dart';
import 'package:ukk_2025/produk/indexproduk.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Updateproduk extends StatefulWidget {
  final int produkid;
  const Updateproduk({super.key, required this.produkid});

  @override
  State<Updateproduk> createState() => _UpdateprodukState();
}

class _UpdateprodukState extends State<Updateproduk> {
  final _nmprd = TextEditingController();
  final _harga = TextEditingController();
  final _stok = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _updateproduk();
  }

  Future<void> _updateproduk() async {
    try {
      final data = await Supabase.instance.client
          .from('kasirproduk')
          .select()
          .eq('produkid', widget.produkid)
          .maybeSingle(); // Gunakan maybeSingle() untuk menghindari error jika data tidak ditemukan

      if (data != null) {
        setState(() {
          _nmprd.text = data['namaproduk'] ?? '';
          _harga.text = data['harga']?.toString() ?? '';
          _stok.text = data['stok']?.toString() ?? '';
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Data produk tidak ditemukan!')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $error')),
      );
    }
  }

  Future<void> updateproduk() async {
    if (_formKey.currentState!.validate()) {
      final harga = double.tryParse(_harga.text) ?? 0;
      final stok = int.tryParse(_stok.text) ?? 0;

      try {
        await Supabase.instance.client
            .from('kasirproduk')
            .update({
              'namaproduk': _nmprd.text,
              'harga': harga, // Pastikan harga disimpan sebagai angka
              'stok': stok, // Pastikan stok disimpan sebagai angka
            })
            .eq('produkid', widget.produkid);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => addproduk()),
          (route) => false,
        );
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal memperbarui produk: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Produk'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nmprd,
                decoration: InputDecoration(
                  labelText: 'Nama Produk',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nama produk tidak boleh kosong";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _harga,
                decoration: InputDecoration(
                  labelText: 'Harga',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
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
              SizedBox(height: 16),
              TextFormField(
                controller: _stok,
                decoration: InputDecoration(
                  labelText: 'Stok',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Stok tidak boleh kosong';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Masukkan angka yang valid';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: updateproduk,
                  child: const Text(
                    'Perbarui',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
