import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'Despesa.dart';
import 'ListaDespesasScreen.dart';

class CadastroDespesaScreen extends StatefulWidget {
  @override
  _CadastroDespesaScreenState createState() => _CadastroDespesaScreenState();
}

class _CadastroDespesaScreenState extends State<CadastroDespesaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _descricaoController = TextEditingController();
  final _valorController = TextEditingController();
  final List<Despesa> _despesas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de despesa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _descricaoController,
                decoration: InputDecoration(
                  hintText: 'Descrição da despesa',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a descrição da despesa';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _valorController,
                decoration: InputDecoration(
                  hintText: 'Valor da despesa',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o valor da despesa';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Por favor, insira um valor válido';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState != null &&
                        _formKey.currentState!.validate()) {
                      _despesas.add(Despesa(
                          descricao: _descricaoController.text,
                          valor: double.parse(_valorController.text),
                          paga: false));
                      await _despesas.last.save();

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Despesa salva com sucesso!'),
                        ),
                      );
                      // Limpa os campos do formulário
                      _descricaoController.clear();
                      _valorController.clear();
                    }
                  },
                  child: Text('Salvar'),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListaDespesasScreen(),
                    ),
                  );
                },
                child: Text('Listar despesas'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
