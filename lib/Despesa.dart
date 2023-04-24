import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Despesa {
  final String descricao;
  final double valor;
  bool paga = false;

  Despesa({required this.descricao, required this.valor, required this.paga});

  Map<String, dynamic> toMap() {
    return {
      'descricao': descricao,
      'valor': valor,
      'paga': paga,
    };
  }

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    final despesas = prefs.getStringList('despesas') ?? [];

    despesas.add(json.encode(toMap()));
    await prefs.setStringList('despesas', despesas);
  }

  Future<void> update() async {
    final prefs = await SharedPreferences.getInstance();
    final despesas = prefs.getStringList('despesas') ?? [];

    final index =
        despesas.indexWhere((json) => jsonDecode(json)['paga'] == paga);
    despesas[index] = json.encode(toMap());
    await prefs.setStringList('despesas', despesas);
  }

  factory Despesa.fromJson(Map<String, dynamic> json) {
    return Despesa(
      descricao: json['descricao'],
      valor: json['valor'],
      paga: json['paga'],
    );
  }

  static Future<List<Despesa>> carregarDespesasSalvas() async {
    final prefs = await SharedPreferences.getInstance();
    final despesasJson = prefs.getStringList('despesas') ?? [];
    final despesas =
        despesasJson.map((json) => Despesa.fromJson(jsonDecode(json))).toList();
    return despesas;
  }
}
