import '../models/contests.dart';

final List<Content> dummyContests = [
  Content(
    id: '1',
    name: 'IPHONE 16 PRO',
    imageUrl: 'assets/iphone16_PNG38.png', // Or a URL
    dateStart: DateTime(2025, 9, 1),
    dateEnd: DateTime(2025, 10, 11),
    contentsType: 'Κινητά',
  ),
  Content(
    id: '2',
    name: 'PEUGEOT 208',
    imageUrl: 'assets/peugot.png',
    dateStart: DateTime(2025, 8, 1),
    dateEnd: DateTime(2025, 8, 12),
    contentsType: 'Οχήματα',
  ),
  Content(
    id: '3',
    name: 'TOYOTA PRIUS',
    imageUrl: 'assets/toyota.png',
    dateStart: DateTime(2025, 7, 1),
    dateEnd: DateTime(2025, 7, 22),
    contentsType: 'Οχήματα',
  ),
  // Add more dummy data as needed
];