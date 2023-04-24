import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'Despesa.dart';
import 'CadastroDespesaScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro de Despesas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CadastroDespesaScreen(),
    );
  }
}
