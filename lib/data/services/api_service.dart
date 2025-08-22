import '../models/contests.dart';
import '../models/deals.dart';

final List<Content> dummyContests = [
  Content(
    id: '1',
    name: 'IPHONE 16 PRO',
    imageUrl: 'assets/iphone16_PNG38.png',
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

final List<Deal> dummyDeals = [
  // 🔹 Cosmote Deal
  Deal(
    id: '1',
    name: '50% έκπτωση σε αξεσουάρ κινητής',
    dealImage: 'assets/images/cosmote_deal_image.png',
    companyImage: 'assets/images/cosmote_logo.png',
    details:
        'Εξαργυρώστε τον κωδικό στα καταστήματα COSMOTE και Γερμανός για έκπτωση 50% σε επιλεγμένα αξεσουάρ κινητής.',
    terms:
        'Η προσφορά ισχύει έως 31/12/2025 και δεν συνδυάζεται με άλλες προσφορές. Ισχύει για μία χρήση ανά κωδικό.',
    dealCode: 'COSMO50OFF',
  ),

  // 🔹 Vodafone Deal
  Deal(
    id: '2',
    name: 'Δώρο 5GB για 1 μήνα',
    dealImage: 'assets/images/vodafone_deal_image.jpg',
    companyImage: 'assets/images/vodafone_logo.png',
    details:
        'Ενεργοποιήστε τον κωδικό μέσω του My Vodafone App και αποκτήστε δωρεάν 5GB για χρήση εντός Ελλάδας.',
    terms:
        'Η προσφορά ισχύει για συνδρομητές κινητής Vodafone ιδιώτες και εταιρικούς. Τα δωρεάν GB έχουν ισχύ 30 ημέρες από την ενεργοποίηση.',
    dealCode: 'VODA5GBFREE',
  ),

  // 🔹 Lidl Deal
  Deal(
    id: '3',
    name: '10% έκπτωση σε επιλεγμένα προϊόντα αρτοποιίας',
    dealImage: 'assets/images/lidl_deal_image.png',
    companyImage: 'assets/images/lidl_logo.png',
    details:
        'Επωφεληθείτε από 10% έκπτωση σε όλα τα φρέσκα αρτοσκευάσματα του Lidl. Απλά δείξτε τον κωδικό στο ταμείο.',
    terms:
        'Η προσφορά ισχύει μόνο για αγορές άνω των 5€. Εξαιρούνται συσκευασμένα προϊόντα αρτοποιίας. Ισχύει μέχρι τις 30/11/2025.',
    dealCode: 'LIDLARTOS10',
  ),
];

Future<List<Content>> fetchContests() async {
  await Future.delayed(Duration(seconds: 2));
  // Return the dummy data
  return dummyContests;
}

Future<List<Deal>> apiFetchDeals() async {
  await Future.delayed(Duration(seconds: 2));
  return dummyDeals;
}
