import 'package:flutter/material.dart';
import 'package:newsphone_competitions/models/competition.dart';

class CompetitionsProvider extends ChangeNotifier {
  final List<Competition> _comp = [
    Competition(
      'ΚΕΡΔΙΣΤΕ ΤΟ PEUGEOT 208',
      DateTime(2025, 4, 1),
      'https://www.pngplay.com/wp-content/uploads/13/Peugeot-208-2019-Transparent-PNG.png',
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
      'https://www.pngkit.com/png/full/45-459951_2015-toyota-prius.png',
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
      'https://pngimg.com/uploads/iphone16/iphone16_PNG38.png',
      CompetitionType.phone,
      'Συμμετοχή στον διαγωνισμό για μια μοναδική ευκαιρία να κερδίσεις το νέο IPHONE 16 PRO!',
      [DateTime(2024, 1, 1, 10, 30), DateTime(2024, 1, 1, 17, 30)],
      'IPHONE 16 PRO',
      '14614',
      'PO',
    ),
    Competition(
      'ΚΕΡΔΙΣΤΕ 2 ΗΜΕΡΕΣ ΣΤΟ ΠΕΡΟΥ',
      DateTime(2025, 4, 25),
      'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/2e/d4/78/af/courtyard.jpg',
      CompetitionType.trip,
      'Συμμετοχή στον διαγωνισμό για μια μοναδική ευκαιρία να κερδίσεις ενα 2μερο σε πολυτελές ξενοδοχείο στο Περού',
      [DateTime(2024, 1, 1, 10, 30), DateTime(2024, 1, 1, 17, 30)],
      '2 ΗΜΕΡΕΣ ΣΤΟ ΠΕΡΟΥ',
      '14614',
      'PE',
    ),
  ];

  List<Competition> get comp => _comp;
}
