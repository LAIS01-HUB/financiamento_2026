import 'package:flutter/material.dart';
import 'dart:math';

class FinanciamentoPage extends StatefulWidget {
  const FinanciamentoPage({super.key});

  @override
  State<FinanciamentoPage> createState() => _FinanciamentoPageState();
}

class _FinanciamentoPageState extends State<FinanciamentoPage> {
  final valor = TextEditingController();
  final juros = TextEditingController();
  final parcelas = TextEditingController();
  final extras = TextEditingController();

  String resultado = "";

  void calcular() {
    double v = double.tryParse(valor.text) ?? 0;
    double j = (double.tryParse(juros.text) ?? 0) / 100;
    int n = int.tryParse(parcelas.text) ?? 0;
    double e = double.tryParse(extras.text) ?? 0;

    double total = v * pow((1 + j), n) + e;
    double parcela = total / n;

    setState(() {
      resultado =
          "Total: R\$ ${total.toStringAsFixed(2)}\nParcela: R\$ ${parcela.toStringAsFixed(2)}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Simulador")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            campo(valor, "Valor"),
            campo(juros, "Juros (%)"),
            campo(parcelas, "Parcelas"),
            campo(extras, "Taxas extras"),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: calcular, child: const Text("Calcular")),
            const SizedBox(height: 20),
            Text(resultado, style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }

  Widget campo(TextEditingController c, String t) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: c,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: t,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}