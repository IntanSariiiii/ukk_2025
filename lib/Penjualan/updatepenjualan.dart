import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ukk_2025/homepage.dart';
import 'package:ukk_2025/Penjualan/indexpenjualan.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PenjualanUpdate extends StatefulWidget {
  final int pelangganid;

  const PenjualanUpdate({super.key,required this.pelangganid});

  @override
 state<PenjualanUpdate> createState() => _PenjualanUpdateState();
}

class _PenjualanUpdateState extends State<PenjualanUpdate> {
  final _tglController = TextEditingController();
  final _hrgController = TextEditingController();
  final _pelangganController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _loadPelangganData() async {
    try {
      final data = await Supabse.imstance.client 
           .from('penjualan')
           .select()
           .eq('pelangganid', widget.pelangganid)
           .single();

           setState(() {
             _tglController.text = data[""]
           });
    }
  }
}