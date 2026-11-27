import '../../flavors/flavor_config.dart';
import '../models/contests.dart';
import '../models/deals.dart';

/// Made-up contests and deals for store screenshots.
///
/// Used only when the app is built with `--dart-define=DEMO_DATA=true`.
/// Normal builds never use this: [enabled] is a compile-time constant that is
/// `false` unless the flag is passed, so the backend is used as always.
///
/// ```bash
/// flutter run --flavor app14800 --dart-define=DEMO_DATA=true
/// ```
///
/// Photos come from Unsplash (free licence). Brand logos are made up and are
/// served from your Mac while taking screenshots (`DEMO_LOGO_HOST`, see
/// FLAVORS.md → "Store screenshots").
class DemoData {
  DemoData._();

  static const bool enabled = bool.fromEnvironment('DEMO_DATA');

  static const String _logoHost = String.fromEnvironment(
    'DEMO_LOGO_HOST',
    defaultValue: 'http://127.0.0.1:8095',
  );

  static String _photo(String id, {int w = 1200, int h = 650}) =>
      'https://images.unsplash.com/$id?w=$w&h=$h&fit=crop&q=80&auto=format';

  static FlavorConfig get _app => FlavorConfig.instance;

  static List<Map<String, Object>> get _shows => [
    {'showId': 901, 'name': 'ΩΡΑ ΕΛΛΑΔΟΣ', 'messagePrefix': 'ΩΕ'},
    {
      'showId': 902,
      'name': 'ΜΕΣΗΜΕΡΙ ΣΤΟ ${_app.stationNameLatin}',
      'messagePrefix': 'ΜΕ',
    },
    {
      'showId': 903,
      'name': 'ΑΠΟΓΕΥΜΑ ΣΤΟ ${_app.stationNameLatin}',
      'messagePrefix': 'ΑΠ',
    },
  ];

  static String get _terms =>
      'Οι όροι του διαγωνισμού θα ανακοινωθούν σύντομα. '
      'Συμμετοχή μέσω κλήσης ή SMS στο ${_app.phoneNumber}.';

  static Map<String, Object?> _contest({
    required String id,
    required String name,
    required String photo,
    required int categoryId,
    required String categoryName,
    required String instructions,
    required String drawDate,
    required int sortOrder,
    bool big = false,
  }) => {
    'id': id,
    'name': name,
    'images': [
      {'id': 9000 + sortOrder, 'imageUrl': photo},
    ],
    'dateStart': '2026-11-01T06:00:00',
    'dateEnd': drawDate,
    'category': {'id': categoryId, 'name': categoryName},
    'is_active': true,
    'instructions': instructions,
    'termsConditions': _terms,
    'shows': _shows,
    'isBigContest': big,
    'priceMobile': '3,29',
    'priceLandline': '3,14',
    'messageSuffix': 'ΟΝΟΜΑΤΕΠΩΝΥΜΟ',
    'callSuffix': 'ΟΝΟΜΑΤΕΠΩΝΥΜΟ - ΤΗΛΕΦΩΝΟ',
    'sortOrder': sortOrder,
  };

  static List<Contest> contests() =>
      [
        _contest(
          id: 'demo-1',
          name: '50.000€ ΜΕΤΡΗΤΑ ΘΑ ΜΟΙΡΑΣΤΟΥΝ ΣΕ 2 ΝΙΚΗΤΕΣ!!!',
          photo:
              'https://storage.googleapis.com/newphone-test.firebasestorage.app/contests/21/e29aef5d-a18e-496c-812f-df138cafb7ca-Designer.jpg',
          categoryId: 4,
          categoryName: 'Μετρητά',
          instructions:
              'ΜΕΓΑΛΟΣ ΔΙΑΓΩΝΙΣΜΟΣ ${_app.stationNameLatin}!\n2 νικητές κερδίζουν από 25.000€ μετρητά!',
          drawDate: '2026-12-31T16:30:00',
          sortOrder: 0,
          big: true,
        ),
        _contest(
          id: 'demo-2',
          name: 'ΚΕΡΔΙΣΤΕ ΕΝΑ ΟΛΟΚΑΙΝΟΥΡΓΙΟ iPHONE 17 PRO',
          photo: _photo('photo-1758327059164-396c3602b8f5'),
          categoryId: 2,
          categoryName: 'Gadgets',
          instructions:
              'Δήλωσε συμμετοχή και κέρδισε το νέο iPhone 17 Pro 256GB!',
          drawDate: '2026-11-28T14:00:00',
          sortOrder: 1,
        ),
        _contest(
          id: 'demo-3',
          name: 'ΔΙΑΚΟΠΕΣ ΓΙΑ 2 ΑΤΟΜΑ ΣΤΗ ΣΑΝΤΟΡΙΝΗ',
          photo: _photo('photo-1570077188670-e3a8d69ac5ff'),
          categoryId: 3,
          categoryName: 'Ταξίδια',
          instructions:
              '5 διανυκτερεύσεις με πρωινό σε boutique ξενοδοχείο στην Οία, μαζί με τα αεροπορικά!',
          drawDate: '2026-12-10T14:00:00',
          sortOrder: 2,
        ),
        _contest(
          id: 'demo-4',
          name: 'ΚΕΡΔΙΣΤΕ ΕΝΑ ΚΑΙΝΟΥΡΓΙΟ ΑΥΤΟΚΙΝΗΤΟ',
          photo: _photo('photo-1643142314913-0cf633d9bbb5'),
          categoryId: 1,
          categoryName: 'Αυτοκίνητο',
          instructions:
              'Ένα ολοκαίνουργιο αυτοκίνητο πόλης μπορεί να γίνει δικό σου!',
          drawDate: '2026-12-20T16:30:00',
          sortOrder: 3,
        ),
      ].map(Contest.fromJson).toList();

  static List<Deal> deals() => [
    Deal(
      id: 'demo-deal-1',
      name: '-25% σε όλο το μενού',
      dealImage: _photo('photo-1414235077428-338989a2e8c0', h: 700),
      companyImage: '$_logoHost/aigaio.png',
      details:
          'Απόλαυσε ελληνική κουζίνα με θέα τη θάλασσα με 25% έκπτωση σε όλο το μενού, κάθε μέρα από Δευτέρα έως Πέμπτη.',
      terms:
          'Ισχύει έως 31/12/2026, για τραπέζι έως 6 ατόμων. Δεν συνδυάζεται με άλλες προσφορές.',
      dealCode: '${_app.phoneNumber}-AIG25',
      isActive: true,
      sortOrder: 0,
    ),
    Deal(
      id: 'demo-deal-2',
      name: '1+1 δώρο στα εισιτήρια σινεμά',
      dealImage: _photo('photo-1578849278619-e73505e9610f', h: 700),
      companyImage: '$_logoHost/lumiere.png',
      details:
          'Αγόρασε ένα εισιτήριο και πάρε το δεύτερο δώρο, για όλες τις ταινίες της εβδομάδας.',
      terms:
          'Ισχύει Δευτέρα έως Τετάρτη, έως 31/12/2026. Ένας κωδικός ανά συναλλαγή.',
      dealCode: '${_app.phoneNumber}-CINE11',
      isActive: true,
      sortOrder: 1,
    ),
    Deal(
      id: 'demo-deal-3',
      name: '-30% σε μασάζ & spa',
      dealImage: _photo('photo-1600334089648-b0d9d3028eb2', h: 700),
      companyImage: '$_logoHost/lotus.png',
      details:
          'Χαλάρωσε με 30% έκπτωση σε όλα τα πακέτα μασάζ και spa, για ένα ή δύο άτομα.',
      terms: 'Ισχύει με κράτηση, έως 31/12/2026. Δεν ισχύει τις αργίες.',
      dealCode: '${_app.phoneNumber}-SPA30',
      isActive: true,
      sortOrder: 2,
    ),
  ];
}
