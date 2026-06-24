import 'package:flutter/material.dart';

///English Terms in Terms of use using Text
final List<Widget> englishTerms = [
  const Text(
    'TERMS OF USE',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
  ),
  const Text(
    '''These terms regulate the use of the "14614 app" application, which is provided by the company named "NEWSPHONE HELLAS SA" with headquarters at 280 Thiseos Ave., Kallithea, Attica, PC 17675 (hereinafter "the Company").

The Company has developed an electronic application that provides users with the opportunity to stay informed and participate in activities (e.g., contests) broadcast on television shows of partner radio and television stations, through landline or mobile telephony by calling/sending a message to premium rate numbers.
Specifically, the "14614 app" allows the user immediate and continuous access (24/7) to contests of the television station ANT1 via landline or mobile phone.
Access consists of the ability to view active contests, facilitate user participation (viewing contests, participation instructions, easy access), and receive informative notifications for current and new contests. Additionally, the application will provide users with the opportunity to receive partner offer codes.
By downloading the application, the user is bound by these Terms of Use and the Newsphone Group Security and Privacy Policy (https://newsphone.gr/privacy-policy/) and declares that they accept them unreservedly.''',
    textAlign: TextAlign.justify,
  ),
  const Text(
    'Age and eligibility requirements',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
  ),
  const Text(
    'The use of the application is permitted to individuals 18 years of age and older. The user declares that their registration information is true, accurate, and complete.',
    textAlign: TextAlign.justify,
  ),
  const Text(
    'Installation and Access to the Application',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
  ),
  const Text(
    '''By installing the "14614 app" on a mobile phone or tablet, the user gains immediate and continuous access (24/7) to the contests of the television station ANT1.
Access to the application can be achieved through one of the following ways:
• Scanning the QR Code displayed on the TV screen during broadcasts.
• Via a link sent to the user as a reply SMS within the framework of their participation in the TV station's contests.
• Searching and installing the application by typing "14614 app" in the Play Store or App Store.''',
    textAlign: TextAlign.justify,
  ),
  const Text(
    'Login and Use of the Application',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
  ),
  const Text(
    '''Upon first entry, the user is asked to accept or reject Push Notifications.
Next, 10 free entries are provided as a reward for initial use. Activation requires identification via a valid mobile phone number. The user enters their number and receives a One Time PIN (OTP) to enter into the app.
Upon successful identification, the 10 free entries are activated and the user gains full access to the application's functions.''',
    textAlign: TextAlign.justify,
  ),
  const Text(
    'Participation in contests',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
  ),
  const Text(
    '''The user selects an active contest and follows these steps:
1. Select the desired contest.
2. Select "Enter Contest".
3. Choose participation method via "Call" or "Send SMS".
By selecting "Call", the user is taken to their device's call environment to call 14614.
By selecting "Send SMS", the user is taken to their device's messaging environment with the participation prefix pre-filled. The user fills in their full name and sends the SMS to 14614.''',
    textAlign: TextAlign.justify,
  ),
  const Text(
    'Free Participations',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
  ),
  const Text(
    '''Upon first use, the user can receive 10 free entries, subject to successful identification.
• Free entries have no charge.
• Free entries are non-transferable, non-exchangeable, and non-redeemable.
After exhaustion, additional participation is exclusively via available methods (Call or SMS) and subject to respective charges.''',
    textAlign: TextAlign.justify,
  ),
  const Text(
    'Charges',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
  ),
  const Text(
    '''The installation and use of the "14614 app" is free.
The charge for participation in ANT1 contests via SMS or Call is: Landline – €3.14/Call, Mobile €3.29/Call, €3.29/SMS. Prices include VAT and mobile telephony fees.''',
    textAlign: TextAlign.justify,
  ),
  const Text(
    'Additional Benefits – Offers & Discount Benefits',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
  ),
  const Text(
    '''The application may provide access to offers, discount coupons, and other privileges from partner businesses.
Offers:
• are provided exclusively by partner companies,
• may be modified or discontinued without notice,
• may be subject to specific terms and restrictions.''',
    textAlign: TextAlign.justify,
  ),
  const Text(
    'Redemption of Offers',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
  ),
  const Text(
    'Redemption is carried out according to the terms set by each partner company and may require showing a coupon code, using a unique code, or physical presence at a store.',
    textAlign: TextAlign.justify,
  ),
  const Text(
    'Limited Liability',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
  ),
  const Text(
    '''The Company makes every effort for the availability of the application but does not guarantee uninterrupted service. The Company is not liable for any damage caused by the use or unavailability of the application.
The app may contain links to third-party websites. The Company is not responsible for the content or privacy policies of these third-party sites.''',
    textAlign: TextAlign.justify,
  ),
  const Text(
    'Personal Data',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
  ),
  const Text(
    'Users\' personal data will be processed according to GDPR regulations (EU 2016/679) and Greek Law 4624/2019.',
    textAlign: TextAlign.justify,
  ),
  const Text(
    'Intellectual Property',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
  ),
  const Text(
    'The application is the exclusive intellectual property of the Company.',
    textAlign: TextAlign.justify,
  ),
  const Text(
    'Amendment of Terms',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
  ),
  const Text(
    'The Company reserves the right to unilaterally modify these Terms of Use.',
    textAlign: TextAlign.justify,
  ),
  const Text(
    'Applicable Law',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
  ),
  const Text(
    'These terms of use are governed by Greek law. Competent courts are the courts of Athens.',
    textAlign: TextAlign.justify,
  ),
  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.apple, size: 24, color: Colors.grey[700]),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            'Apple is not a sponsor of, or involved in, the contest in any manner.',
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[800],
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  ),
  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.android, size: 24, color: Colors.grey[700]),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            'Google is not a sponsor of, or involved in, the contest in any manner.',
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[800],
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  ),
];

///Greek Terms in Terms of use using Text
final List<Widget> greekTerms = [
  const Text(
    'ΟΡΟΙ ΧΡΗΣΗΣ',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
  ),
  const Text(
    '''Οι παρόντες όροι ρυθμίζουν την χρήση της εφαρμογής «14614 app» η οποία παρέχεται από την εταιρεία με την επωνυμία «ΕΙΔΗΣΕΟΦΩΝΙΚΗ ΕΛΛΑΣ - ΑΝΩΝΥΜΗ ΕΜΠΟΡΙΚΗ ΕΤΑΙΡΕΙΑ - ΥΠΗΡΕΣΙΕΣ ΤΗΛΕΗΧΟΠΛΗΡΟΦΟΡΗΣΗΣ- ΟΛΟΚΛΗΡΩΜΕΝΕΣ ΥΠΗΡΕΣΙΕΣ ΠΛΗΡΟΦΟΡΙΚΗΣ ΚΑΙ ΕΠΙΚΟΙΝΩΝΙΩΝ» και τον διακριτικό τίτλο «NEWSPHONE HELLAS SA» με έδρα την Λ. Θησέως 280, Καλλιθέα Αττικής, ΤΚ 17675, αρ. ΓΕΜΗ 123788460000 (εφεξής «η Εταιρεία»).

Η Εταιρεία έχει αναπτύξει ηλεκτρονική εφαρμογή η οποία παρέχει στους χρήστες τη δυνατότητα να ενημερώνονται και να συμμετέχουν σε ενέργειες (ενδεικτικά διαγωνισμούς) που προβάλλονται σε τηλεοπτικές εκπομπές συνεργαζόμενων με την Εταιρεία ραδιοτηλεοπτικών σταθμών, μέσω σταθερής ή κινητής τηλεφωνίας με κλήση/αποστολή μηνύματος σε αριθμούς αυξημένης χρέωσης.
Αναλυτικά, η εφαρμογή «14614 app» επιτρέπει στον χρήστη άμεση και συνεχή πρόσβαση (24/7) στους διαγωνισμούς των τηλεοπτικών εκπομπών του τηλεοπτικού σταθμού ΑΝΤ1 μέσω σταθερής ή κινητής τηλεφωνίας με κλήση/αποστολή μηνύματος σε αριθμούς αυξημένης χρέωσης.
Η πρόσβαση συνίσταται στη δυνατότητα προβολής των ενεργών διαγωνισμών, στη διευκόλυνση της συμμετοχής του χρήστη σε διαγωνισμό (προβολή διαγωνισμών, οδηγίες συμμετοχής, εύκολη πρόσβαση) και την λήψη ενημερωτικών ειδοποιήσεων για τους τρέχοντες και νέους διαγωνισμούς. Επιπλέον, η εφαρμογή θα παρέχει στους χρήστες τη δυνατότητα να λαμβάνουν κωδικούς προσφορών συνεργατών (για εκπτώσεις σε προϊόντα, υπηρεσίες ή καταστήματα συνεργατών)
Με την καταφόρτωση της εφαρμογής ο χρήστης δεσμεύεται από τους παρόντες Όρους Χρήσης και την Πολιτική Ασφάλειας και Προστασίας Προσωπικών Δεδομένων Ομίλου Newsphone (https://newsphone.gr/privacy-policy/) και δηλώνει ότι τους αποδέχεται ανεπιφύλακτα.''',
    textAlign: TextAlign.justify,
  ),
  const Text(
    'Ηλικία και απαιτήσεις καταλληλότητας',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
  ),
  const Text(
    'Η χρήση της εφαρμογής επιτρέπετε σε άτομα 18 ετών και άνω. Ο χρήστης δηλώνει ότι οι πληροφορίες εγγραφής του είναι αληθείς, ακριβείς και πλήρεις.',
    textAlign: TextAlign.justify,
  ),
  const Text(
    'Εγκατάσταση και Πρόσβαση στην Εφαρμογή',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
  ),
  const Text(
    '''Με την εγκατάσταση της εφαρμογής «14614 app» σε κινητό τηλέφωνο ή tablet, ο χρήστης αποκτά άμεση και συνεχή πρόσβαση (24/7) στους διαγωνισμούς των τηλεοπτικών εκπομπών του τηλεοπτικού σταθμού ΑΝΤ1.
Η πρόσβαση στην εφαρμογή μπορεί να πραγματοποιηθεί με έναν από τους ακόλουθους τρόπους:
• Σάρωση (scan) του QR Code που εμφανίζεται στην τηλεοπτική οθόνη κατά τη διάρκεια των εκπομπών.
• Μέσω συνδέσμου (link) που αποστέλλεται στον χρήστη ως απαντητικό SMS, στο πλαίσιο συμμετοχής του στους διαγωνισμούς του τηλεοπτικού σταθμού.
• Αναζήτηση και εγκατάσταση της εφαρμογής πληκτρολογώντας «14614 app» στο Play Store ή στο App Store.''',
    textAlign: TextAlign.justify,
  ),
  const Text(
    'Είσοδος και Χρήση της Εφαρμογής',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
  ),
  const Text(
    '''Κατά την πρώτη είσοδο στην εφαρμογή, ο χρήστης καλείται να αποδεχθεί ή να απορρίψει τη λήψη Ενημερωτικών Ειδοποιήσεων (Push Notifications).
Στη συνέχεια, παρέχεται η δυνατότητα λήψης 10 δωρεάν συμμετοχών ως ανταμοιβή για την αρχική χρήση της εφαρμογής. Για την ενεργοποίηση των δωρεάν συμμετοχών απαιτείται ταυτοποίηση μέσω έγκυρου αριθμού κινητού τηλεφώνου. Ο χρήστης εισάγει τον αριθμό του σε ειδικό πεδίο και λαμβάνει κωδικό μιας χρήσης (One Time PIN – OTP), τον οποίο πρέπει να καταχωρήσει στην εφαρμογή.
Με την επιτυχή ολοκλήρωση της διαδικασίας ταυτοποίησης, οι 10 δωρεάν συμμετοχές ενεργοποιούνται και ο χρήστης αποκτά πλήρη πρόσβαση στις λειτουργίες της εφαρμογής.''',
    textAlign: TextAlign.justify,
  ),
  const Text(
    'Συμμετοχή στους διαγωνισμούς',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
  ),
  const Text(
    '''Ο χρήστης επιλέγει έναν από τους διαθέσιμους ενεργούς διαγωνισμούς και ακολουθεί τα παρακάτω βήματα:
1. Επιλογή του επιθυμητού διαγωνισμού.
2. Επιλογή της ενέργειας «Δήλωσε Συμμετοχή».
3. Επιλογή τρόπου συμμετοχής μέσω των επιλογών «Κάλεσε» ή «Στείλε SMS».
Με την επιλογή «Κάλεσε», ο χρήστης μεταφέρεται στο περιβάλλον κλήσεων της συσκευής του, όπου μπορεί να πραγματοποιήσει κλήση προς τον αριθμό 14614.
Με την επιλογή «Στείλε SMS», ο χρήστης μεταφέρεται στο περιβάλλον αποστολής μηνυμάτων της συσκευής του, όπου έχει ήδη δημιουργηθεί αυτόματα το πρόθεμα συμμετοχής. Ο χρήστης συμπληρώνει το ονοματεπώνυμό του και αποστέλλει το SMS στον αριθμό 14614.''',
    textAlign: TextAlign.justify,
  ),
  const Text(
    'Δωρεάν Συμμετοχές',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
  ),
  const Text(
    '''Κατά την πρώτη χρήση της εφαρμογής, ο χρήστης μπορεί να λάβει 10 δωρεάν συμμετοχές, υπό την προϋπόθεση επιτυχούς ταυτοποίησης μέσω έγκυρου αριθμού κινητού τηλεφώνου.
• Οι δωρεάν συμμετοχές δεν συνεπάγονται καμία χρέωση.
• Οι δωρεάν συμμετοχές δεν μεταβιβάζονται, δεν ανταλλάσσονται και δεν εξαργυρώνονται.
Μετά την εξάντλησή τους, κάθε επιπλέον συμμετοχή πραγματοποιείται αποκλειστικά μέσω των διαθέσιμων τρόπων συμμετοχής (κλήση ή SMS) και υπόκειται στις αντίστοιχες χρεώσεις.''',
    textAlign: TextAlign.justify,
  ),
  const Text(
    'Χρεώσεις',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
  ),
  const Text(
    '''Η εγκατάσταση και χρήση της εφαρμογής «14614 app» είναι δωρεάν.
Η χρέωση για τη συμμετοχή στους διαγωνισμούς των εκπομπών του τηλεοπτικού σταθμού ΑΝΤ1 μέσω SMS ή Κλήσης είναι η εξής: Σταθερό – €3,14/Κλήση, Κινητό €3,29/Κλήση, €3,29/SMS. Οι τιμές περιλαμβάνουν ΦΠΑ και τέλη συνδρομητών κινητής τηλεφωνίας.''',
    textAlign: TextAlign.justify,
  ),
  const Text(
    'Επιπλέον Παροχές – Προσφορές & Εκπτωτικά Οφέλη',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
  ),
  const Text(
    '''Η εφαρμογή «14614 app» δύναται να παρέχει στους χρήστες πρόσβαση σε προσφορές, εκπτωτικά κουπόνια, δωροεπιταγές, προωθητικές ενέργειες και άλλα προνόμια που προσφέρονται από συνεργαζόμενες επιχειρήσεις και εμπορικούς συνεργάτες.

Οι Προσφορές:
• παρέχονται αποκλειστικά από τις συνεργαζόμενες εταιρείες,
• ενδέχεται να διαφοροποιούνται, να τροποποιούνται ή να διακόπτονται χωρίς προηγούμενη ειδοποίηση,
• μπορεί να υπόκεινται σε ειδικούς όρους, χρονικούς περιορισμούς, ελάχιστες αγορές ή άλλες προϋποθέσεις που καθορίζονται από τον εκάστοτε πάροχο της προσφοράς.''',
    textAlign: TextAlign.justify,
  ),
  const Text(
    'Εξαργύρωση Προσφορών',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
  ),
  const Text(
    '''Η εξαργύρωση των Προσφορών πραγματοποιείται σύμφωνα με τους όρους που θέτει κάθε συνεργαζόμενη εταιρεία και μπορεί να απαιτεί:
• επίδειξη κωδικού κουπονιού
• χρήση μοναδικού κωδικού
• καταχώριση κωδικού σε ηλεκτρονικό κατάστημα
• φυσική παρουσία σε κατάστημα
• ή οποιαδήποτε άλλη διαδικασία ορίζει ο πάροχος της προσφοράς''',
    textAlign: TextAlign.justify,
  ),
  const Text(
    'Περιορισμένη ευθύνη',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
  ),
  const Text(
    '''Η Εταιρεία παρέχει στους χρήστες της εφαρμογής πρόσβαση σε πληροφορίες που παρέχονται από τρίτα μέρη. Τα τρίτα αυτά μέρη είναι υπεύθυνα για τις πληροφορίες αυτές που μεταφέρονται στην Εταιρεία ή συνδέονται με την Εταιρεία μέσω σχετικών συνδέσμων.

Η Εταιρεία καταβάλλει κάθε δυνατή προσπάθεια για τη διαθεσιμότητα και λειτουργία της εφαρμογής και των πληροφοριακών της συστημάτων, δεν εγγυάται όμως ότι η εφαρμογή θα παρέχεται χωρίς διακοπές ή σφάλματα. Λόγω τεχνικών συνθηκών, τις οποίες δεν επηρεάζει η Εταιρεία, μπορεί να παρουσιαστούν διακοπές, ειδικότερα σε περίπτωση μη διαθεσιμότητας του τηλεπικοινωνιακού δικτύου ή των παρόχων πληροφοριακών ή άλλων υποδομών.
Επίσης, διακοπές δύναται να παρατηρηθούν στην περίπτωση μέτρων συντήρησης και επικαιροποίησης. Ο χρήστης δηλώνει ότι είναι σύμφωνος με τέτοια μέτρα. Μία τέτοια προσωρινή μη διαθεσιμότητα της εφαρμογής δεν αποτελεί ελάττωμα. Η Εταιρεία δεν ευθύνεται για οποιαδήποτε μορφής ζημία υποστεί ο χρήστης ή εξαιτίας της χρήσης ή / και της μη διαθεσιμότητας της χρήσης της εφαρμογής ή την παύση λειτουργίας της εφαρμογής εν όλω ή εν μέρει.
Η εφαρμογή ενδέχεται περιλαμβάνει links ("συνδέσμους") σε ιστοσελίδες τρίτων διαδικτυακούς τόπους, οι οποίοι ελέγχονται από τρίτους φορείς. Οι σύνδεσμοι παρέχονται προς διευκόλυνση των χρηστών και δεν συνεπάγεται ότι η Εταιρεία υποστηρίζει αυτές τις ιστοσελίδες ή αποδέχεται το περιεχόμενο τους. Στην περίπτωση που επιλεγεί η χρήση αυτών των συνδέσμων ο χρήστης θα πρέπει να γνωρίζει ότι φεύγει από το περιβάλλον της εφαρμογής της Εταιρείας και ότι η Εταιρεία δεν έχει κανένα έλεγχο στις ιστοσελίδες τρίτων. Επομένως, σε καμία περίπτωση δεν ευθύνεται η Εταιρεία για το περιεχόμενό των διαδικτυακών τόπων στους οποίους παραπέμπουν οι σύνδεσμοι, ούτε για την προστασία του απορρήτου των πληροφοριών που ο χρήστης παρέχει κατά την επίσκεψη του σε ιστοσελίδες τρίτων, ούτε για οποιαδήποτε οικονομική ή άλλης φύσεως ζημία ή βλάβη τυχόν υποστεί. Οι παρόντες όροι δεν ισχύουν για τις ιστοσελίδες τρίτων. Ο χρήστης θα πρέπει να ενεργεί με προσοχή και να ενημερώνεται για την πολιτική τήρησης του απορρήτου των ιστοσελίδων που επισκέπτεται.
Η Εταιρεία δεν εγγυάται ότι η εφαρμογή δεν θα προβληθεί από ιούς ή κακόβολο λογισμικό, παρά τα μέτρα προστασίας που εφαρμόζει. Ο κάθε χρήστης είναι αποκλειστικά υπεύθυνος για την προστασία του προσωπικού του εξοπλισμού και λογισμικού από ιούς.''',
    textAlign: TextAlign.justify,
  ),
  const Text(
    'Προσωπικά δεδομένα',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
  ),
  const Text(
    '''Τα προσωπικά δεδομένα των χρηστών θα τύχουν επεξεργασίας κατά την έννοια του ΓΚΠΔ, η οποία είναι αναγκαία προκειμένου οι χρήστες να χρησιμοποιήσουν την εφαρμογή και να λαμβάνουν ενημερώσεις και επιμέρους προσφορές. Η Εταιρεία συμμορφώνεται πλήρως με την ισχύουσα νομοθεσία περί προστασίας δεδομένων, ως εκάστοτε ισχύει, και ιδίως το Ν. 4624/2019, τον Γενικό Κανονισμό Προστασίας Δεδομένων (ΕΕ) 2016/679 (εφεξής “GDPR”) και οποιαδήποτε άλλη νομοθεσία εφαρμόζει, τροποποιεί, συμπληρώνει ή αντικαθιστά τα ανωτέρω, καθώς και τις αποφάσεις και οδηγίες της Αρχής Προστασίας Δεδομένων Προσωπικού Χαρακτήρα στο βαθμό που εξακολουθούν να ισχύουν και επιβεβαιώνει ότι οποιαδήποτε τυχόν επεξεργασία αυτών θα πραγματοποιηθεί σύμφωνα με την εν λόγω νομοθεσία.
Επισημαίνεται ότι εφόσον οι χρήστες επιλέξουν να προχωρήσουν σε συμμετοχή σε διαγωνισμούς, τότε ισχύουν οι διατάξεις εκάστου διαγωνισμού συμπεριλαμβανομένων των διατάξεων περί επεξεργασίας προσωπικών δεδομένων.
Ομοίως, εφόσον οι χρήστες προχωρήσουν σε λήψη προσφορών και προωθητικών ενεργειών συνεργαζόμενων εταιρειών, υπάγονται στους όρους χρήσης παροχής υπηρεσιών των συνεργατών αυτών, οι οποίοι θα είναι υπεύθυνοι για την επεξεργασία των προσωπικών δεδομένων τους.''',
    textAlign: TextAlign.justify,
  ),
  const Text(
    'Πνευματική ιδιοκτησία',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
  ),
  const Text(
    '''Η εφαρμογή αποτελεί αποκλειστική πνευματική ιδιοκτησία της Εταιρείας με την επιφύλαξη δικαιωμάτων τρίτων. Η Εταιρεία είναι δικαιούχος των δικαιωμάτων πνευματικής ιδιοκτησίας επί του περιεχόμενου και των στοιχείων που η ίδια παράγει και εισάγει στην εφαρμογή (συμπεριλαμβανομένων, ενδεικτικά, κειμένων, φωτογραφιών, γραφικών, βίντεο, εμπορικών σημάτων και οποιωνδήποτε άλλων διακριτικών γνωρισμάτων) ή νόμιμος χρήστης για τους σκοπούς προώθησης των υπηρεσιών της παρούσας, όσων από τα παραπάνω αποτελούν πνευματική ιδιοκτησία τρίτων, τα οποία, σε κάθε περίπτωση, προστατεύονται στο σύνολό τους από την νομοθεσία περί πνευματικής και βιομηχανικής ιδιοκτησίας.''',
    textAlign: TextAlign.justify,
  ),
  const Text(
    'Τροποποίηση Όρων',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
  ),
  const Text(
    'Η Εταιρεία διατηρεί το δικαίωμα να τροποποιεί μονομερώς τους παρόντες Όρους Χρήσης κατά την απόλυτη διακριτική της ευχέρεια, χωρίς προηγούμενη ενημέρωση ή άλλη διατύπωση.',
    textAlign: TextAlign.justify,
  ),
  const Text(
    'Ισχύον Δίκαιο',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
  ),
  const Text(
    'Οι παρόντες όροι χρήσης διέπονται από το ελληνικό δίκαιο. Σε περίπτωση διαφοράς που ανακύψει σε σχέση με τους παρόντες όρους αρμόδια ορίζονται τα δικαστήρια των Αθηνών.',
    textAlign: TextAlign.justify,
  ),
  const Text(
    'Οι όροι έχουν κατατεθεί στην συμβολαιογράφο Αθηνών Κυριακή Ανωμερίτη, κάτοικο Αθηνών (οδός Σκουφά 66).',
    textAlign: TextAlign.justify,
  ),
  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.apple, size: 24, color: Colors.grey[700]),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            'Η Apple δεν είναι χορηγός και δεν συμμετέχει με κανέναν τρόπο στον διαγωνισμό.',
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[800],
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  ),
  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.android, size: 24, color: Colors.grey[700]),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            'Η Google δεν είναι χορηγός και δεν συμμετέχει με κανέναν τρόπο στον διαγωνισμό.',
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[800],
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  ),
];