import 'package:flutter/cupertino.dart';

import '../models/scan_model.dart';
import 'db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  // Classe provider amb la cual agafare els valors de la base de dades i els introduirem dintre de una llista per poder visualitzarlos, es una clase provider perque quan alguna cosa canvii o poguem visualitzar.
  List<ScanModel> scans = []; // Cream la llista.

  Future<ScanModel> nouScan(String titol, String quantitat) async {
    final nouScan = ScanModel(titol: titol, quantitat: quantitat);
    final id = await DBProvider.db.insertScan(nouScan);
    nouScan.id = id;

    this.scans.add(nouScan);
    notifyListeners();

    return nouScan;
  }

  // Carregam tots els valors de la base de dades i els introduim dintre de la llista.
  carregarScans() async {
    final scans = await DBProvider.db.getAllScans();
    this.scans = [...scans];
    notifyListeners();
  }

  // Metode que esborra tots els valors de la llista.
  esborraTots() async {
    final scans = await DBProvider.db.deleteAllScans();
    this.scans = [];
    notifyListeners();
  }

  // Metode que borra de la llista el valor a partir del seu id.
  esborraPerId(int id) async {
    final scans = await DBProvider.db.deleteScan(id);
    this.scans.removeAt(scans);
    notifyListeners();
  }
}
