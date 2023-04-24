import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'Despesa.dart';

class ListaDespesasScreen extends StatefulWidget {
  @override
  _ListaDespesasScreenState createState() => _ListaDespesasScreenState();
}

class _ListaDespesasScreenState extends State<ListaDespesasScreen> {
  List<Despesa> _despesas = [];

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    final despesas = await Despesa.carregarDespesasSalvas();
    setState(() {
      _despesas = despesas;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de despesas'),
      ),
      body: ListView.builder(
        itemCount: _despesas.length,
        itemBuilder: (context, index) {
          final despesa = _despesas[index];
          return ListTile(
            title: Text(despesa.descricao),
            subtitle: Text('R\$ ${despesa.valor.toStringAsFixed(2)}'),
            //botao para mudar o estado da despesa para paga e deixar o texto verde
            trailing: Checkbox(
              value: despesa.paga,
              onChanged: (value) {
                setState(() {
                  despesa.paga = value!;
                  despesa.update();
                });
              },
            ),
          );
        },
      ),
    );
  }
}
