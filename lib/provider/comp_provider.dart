import 'package:flutter/material.dart';
import 'package:newsphone_competitions/models/competition.dart';

import '../DatabaseHelper.dart';

class CompetitionsProvider extends ChangeNotifier {
  final DatabaseHelper _db = DatabaseHelper.instance;

  final List<Competition> _comp = [
    Competition(
      'ΚΕΡΔΙΣΤΕ ΤΟ PEUGEOT 208',
      DateTime(2025, 4, 1),
      'assets/Peugeot-208-2019-Transparent-PNG.png',
      CompetitionType.vehicle,
      'Συμμετοχή στον διαγωνισμό για μια μοναδική ευκαιρία να κερδίσεις το νέο Peugeot 208!',
      [DateTime(2024, 1, 1, 05, 30), DateTime(2024, 1, 1, 09, 30)],
      'PEUGEOT 208',
      '14614',
      'TO',
    ),
    Competition(
      'ΚΕΡΔΙΣΤΕ ΤΟ TOYOTA PRIUS',
      DateTime(2025, 3, 31),
      'assets/toyota.png',
      CompetitionType.vehicle,
      'Συμμετοχή στον διαγωνισμό για μια μοναδική ευκαιρία να κερδίσεις το νέο Toyota PRIUS!',
      [DateTime(2024, 1, 1, 10, 30), DateTime(2024, 1, 1, 17, 30)],
      'TOYOTA PRIUS',
      '14614',
      'KE',
    ),
    Competition(
      'ΚΕΡΔΙΣΤΕ ΤΟ IPHONE 16 PRO',
      DateTime(2025, 3, 31),
      'assets/iphone16_PNG38.png',
      CompetitionType.phone,
      'Συμμετοχή στον διαγωνισμό για μια μοναδική ευκαιρία να κερδίσεις το νέο IPHONE 16 PRO!',
      [DateTime(2024, 1, 1, 10, 30), DateTime(2024, 1, 1, 17, 30)],
      'IPHONE 16 PRO',
      '14614',
      'PO',
    ),
    Competition(
      'ΚΕΡΔΙΣΤΕ 2 ΗΜΕΡΕΣ ΣΤΟ ΠΕΡΟΥ',
      DateTime(2025, 3, 20),
      'assets/courtyard.jpg',
      CompetitionType.trip,
      'Συμμετοχή στον διαγωνισμό για μια μοναδική ευκαιρία να κερδίσεις ενα 2μερο σε πολυτελές ξενοδοχείο στο Περού',
      [DateTime(2024, 1, 1, 10, 30), DateTime(2024, 1, 1, 17, 30)],
      '2 ΗΜΕΡΕΣ ΣΤΟ ΠΕΡΟΥ',
      '14614',
      'PE',
    ),
  ];

  List<Competition> get comp => _comp;

  final Set<String> _selectedFilters = {};

  Set<String> get selectedFilters => _selectedFilters;

  void toggleFilter(String type, bool value) {
    if (value) {
      _selectedFilters.add(type);
      _db.insertFavorite(type);
    } else {
      _selectedFilters.remove(type);
      _db.deleteFavorite(type);
    }
    notifyListeners();
  }

  List<Competition> get filteredItems {
    if (_selectedFilters.isEmpty) {
      return _comp;
    } else {
      return _comp
          .where((item) => _selectedFilters.contains(item.type.toString()))
          .toList();
    }
  }
}
