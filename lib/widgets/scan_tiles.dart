import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/scan_list_provider.dart';

class ScanTiles extends StatelessWidget {
  // Classe que basicament el que fa es crear un list builder i depengent el tipus que sigui, agafara un valor o un altre de la llista.

  const ScanTiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: ((_, index) => Dismissible(
            key: UniqueKey(),
            background: Container(
              color: Colors.red,
              child: const Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.delete_forever),
                ),
              ),
            ),
            onDismissed: (DismissDirection direccio) {
              Provider.of<ScanListProvider>(context, listen: false)
                  .esborraPerId(scans[index].id!);
            },
            child: ListTile(
                title: Text(scans[index].titol),
                subtitle: Text(scans[index].id.toString()),
                trailing: Text(scans[index].quantitat)),
          )),
    );
  }
}
