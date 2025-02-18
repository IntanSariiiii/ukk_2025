import 'package:flutter/material.dart';
import 'package:ukk_2025/Produk/insertproduk.dart';
import 'package:ukk_2025/Produk/updateproduk.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProdukTab extends StatefulWidget {
  const ProdukTab({super.key});

  @override
  State<ProdukTab> createState() => _ProdukTabState();
}

class _ProdukTabState extends State<ProdukTab> {
  List<Map<String, dynamic>> produk = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchProduk();
  }

  /// Fungsi untuk mengambil data produk dari Supabase
  Future<void> fetchProduk() async {
    setState(() => isLoading = true);
    try {
      final List<dynamic> response =
          await Supabase.instance.client.from('ukk_2025').select();

      setState(() {
        produk = response.map((item) => Map<String, dynamic>.from(item)).toList();
        isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
      setState(() => isLoading = false);
    }
  }

  /// Fungsi untuk menghapus produk berdasarkan ID
  Future<void> deleteProduk(int id) async {
    try {
      await Supabase.instance.client.from('ukk_2025').delete().eq('produkid', id);
      fetchProduk();
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : produk.isEmpty
              ? const Center(
                  child: Text(
                    'Tidak ada produk tersedia',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: produk.length,
                  itemBuilder: (context, index) {
                    final prd = produk[index];
                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: SizedBox(
                        width: double.infinity,
                        height: 185,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                prd['namaproduk'] ?? 'Nama tidak tersedia',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Harga: ${prd['harga'] ?? 'Tidak tersedia'}',
                                style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 16, color: Colors.grey),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Stok: ${prd['stok'] ?? 'Tidak tersedia'}',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              const Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit, color: Colors.blueAccent),
                                    onPressed: () {
                                      final produkid = prd['produkid'] ?? 0;
                                      if (produkid != 0) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Updateproduk(produkid: produkid),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Hapus Produk'),
                                            content: const Text('Apakah Anda yakin ingin menghapus produk ini?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(context),
                                                child: const Text('Batal'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  deleteProduk(prd['produkid']);
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Hapus'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => addproduk()),
          );

          if (result == true) {
            fetchProduk();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.green),
                    const SizedBox(width: 8),
                    const Text('Produk berhasil ditambahkan!'),
                  ],
                ),
                backgroundColor: Colors.black87,
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
