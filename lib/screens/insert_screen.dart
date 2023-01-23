import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simulacre_franciscojaner/providers/scan_list_provider.dart';

class InsertScreen extends StatelessWidget {
  const InsertScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titol = TextEditingController();
    final TextEditingController quantitat = TextEditingController();

    final scanListProvider = Provider.of<ScanListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insertar'),
      ),
      body: Column(
        children: [
          const Divider(),
          TextFormField(
            controller: titol,
            onChanged: (value) {},
            decoration: const InputDecoration(
              labelText: 'Titol',
              icon: Icon(Icons.title),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 3),
              ),
            ),
          ),
          const Divider(),
          TextFormField(
            controller: quantitat,
            onChanged: (value) {},
            decoration: const InputDecoration(
              labelText: 'Quantitat',
              icon: Icon(Icons.numbers_outlined),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 3),
              ),
            ),
          ),
          const Divider(),
          ElevatedButton(
            onPressed: () {
              scanListProvider.nouScan(titol.text, quantitat.text);
              Navigator.pop(context);
            },
            child: const Text('Insertar'),
          )
        ],
      ),
    );
  }
}
