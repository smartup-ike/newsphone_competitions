import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsphone_competitions/core/themes/newsphone_theme.dart';
import 'package:newsphone_competitions/presentation/pages/coupons/success_auth.dart';
import '../../../core/themes/newsphone_typography.dart';
import '../../../logic/blocs/auth/auth_cubit.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // Using a single controller for the phone number
  final _phoneController = TextEditingController();

  String? _phoneError;

  bool _isValidPhone(String phone) {
    // Basic Greek phone validation: 10 digits starting with 6
    final regex = RegExp(r'^6\d{9}$');
    return regex.hasMatch(phone);
  }

  void _onContinue() {
    final phone = _phoneController.text.trim();
    if (!_isValidPhone(phone)) {
      setState(() {
        _phoneError = 'Μη έγκυρος αριθμός κινητού'; // Invalid phone number
      });
      return;
    }

    setState(() => _phoneError = null);

    // Continue with AuthCubit
    context.read<AuthCubit>().verifyPhone('+30$phone');
  }

  // Using 6 separate controllers for the 6-digit SMS code
  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _otpFocusNodes = List.generate(6, (_) => FocusNode());

  // Helper to combine OTP controllers into a single string
  String get _otpCode => _otpControllers.map((c) => c.text).join();

  @override
  void dispose() {
    _phoneController.dispose();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _otpFocusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  final Color buttonColor = const Color(0xFF3B5998);
  Widget _buildOtpBox(int index) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade300, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: TextFormField(
          controller: _otpControllers[index],
          focusNode: _otpFocusNodes[index],
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          maxLength: 1,
          // Only one character per field
          style: NewsphoneTypography.heading5Bold,
          // Make the number large and bold
          decoration: const InputDecoration(
            counterText: "", // Hide the character counter
            border: InputBorder.none, // Hide the default border
            contentPadding: EdgeInsets.zero,
          ),
          onChanged: (value) {
            // Auto-move focus to the next field
            if (value.isNotEmpty && index < _otpControllers.length - 1) {
              FocusScope.of(context).requestFocus(_otpFocusNodes[index + 1]);
            }
            // If the user deletes a character, move focus back
            if (value.isEmpty && index > 0) {
              FocusScope.of(context).requestFocus(_otpFocusNodes[index - 1]);
            }
          },
        ),
      ),
    );
  }

  // --- END OF OTP DIGIT BOX WIDGET ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NewsphoneTheme.neutral95,
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                floating: false,
                pinned: true,
                centerTitle: true,
                title: Text(
                  'Επιβεβαίωση Κινητού Αριθμού',
                  style: NewsphoneTypography.body17SemiBold,
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(1.0),
                  child: Container(color: Colors.grey[300], height: 1.0),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // 2. Specify the bottom corners to be rounded
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      // Adjust the radius as needed
                      bottomRight: Radius.circular(
                        20.0,
                      ), // Adjust the radius as needed
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 20,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (state.verificationId == null)
                              ? 'Εξασφαλίστε τα 10 Κουπόνια σας!'
                              : 'Επιβεβαίωση Κωδικού (OTP)',
                          style: NewsphoneTypography.heading6Bold,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          (state.verificationId == null)
                              ? 'Για να ολοκληρωθεί η απόδοση των 10 κουπονιών και να επιβεβαιώσουμε την ταυτότητά σας (ώστε να λάβετε επίσημα τα δώρα σας), παρακαλούμε εισάγετε τον αριθμό του κινητού σας. Θα σας στείλουμε άμεσα έναν 6ψήφιο κωδικό επιβεβαίωσης (OTP) για το επόμενο βήμα.'
                              : 'Μόλις σας στείλαμε έναν 6ψήφιο κωδικό επιβεβαίωσης (OTP) με SMS στον αριθμό που δηλώσατε: XXXX-XXX423 \n \n Εισάγετε τον κωδικό παρακάτω για να επιβεβαιώσετε τον λογαριασμό σας και να λάβετε άμεσα τα 10 κουπόνια.',
                          style: NewsphoneTypography.body13Regular.copyWith(
                            color: NewsphoneTheme.neutral40,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child:
                    (state.verificationId == null)
                        ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 50),
                            // --- Phone Number Input Style ---
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                ),
                                // Padding inside the container
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.0),
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                  // Light grey border
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: const Offset(
                                        0,
                                        3,
                                      ), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    // Flag and Country Code Text
                                    const Row(
                                      children: [
                                        Text(
                                          '🇬🇷',
                                          style: TextStyle(fontSize: 24),
                                        ),
                                        SizedBox(width: 4),
                                        Icon(
                                          Icons.arrow_right,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      height: 30,
                                      width: 1,
                                      color: Colors.grey.shade300,
                                    ),
                                    const SizedBox(width: 8),
                                    // Phone Number Input Field
                                    Expanded(
                                      child: TextField(
                                        controller: _phoneController,
                                        keyboardType: TextInputType.phone,
                                        decoration: InputDecoration(
                                          labelText:
                                          _phoneError ?? 'Αριθμός Κινητού Τηλεφώνου',
                                          labelStyle: TextStyle(color: _phoneError == null ? Colors.black : Colors.red,),
                                          // Greek text from the image
                                          prefixText: '+30 ',
                                          border: InputBorder.none,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                vertical: 15.0,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 25),

                            // Spacing between input and button
                            GestureDetector(
                              onTap: _onContinue,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0,
                                ),
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: NewsphoneTheme.primary,
                                    borderRadius: BorderRadius.circular(24.0),
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  width: double.infinity,
                                  child: Center(
                                    child: Text(
                                      "Συνέχεια & Αποστολή Κωδικού",
                                      textAlign: TextAlign.center,
                                      style: NewsphoneTypography.body17SemiBold
                                          .copyWith(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 10,
                              ),
                              child: Text(
                                'Ο αριθμός σας χρησιμοποιείται αποκλειστικά για την επιβεβαίωση της συμμετοχής σας και την ενημέρωσή σας σε περίπτωση νίκης, χωρίς καμία χρέωση. Διαβάστε τους Όρους Χρήσης.',
                                style: NewsphoneTypography.body12Regular
                                    .copyWith(color: NewsphoneTheme.neutral30),
                              ),
                            ),
                          ],
                        )
                        : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 25),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(
                                  _otpControllers.length,
                                  (index) => _buildOtpBox(index),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),

                            BlocListener<AuthCubit, AuthState>(
                              listener: (context, state) {
                                if (state.smsStatus == SmsStatus.success) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (_) => SuccessAuth()),
                                  );
                                } else if (state.smsStatus == SmsStatus.failure) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(state.errorMessage ?? 'Σφάλμα επαλήθευσης')),
                                  );
                                }
                              },
                              child: GestureDetector(
                                onTap: () {
                                  context.read<AuthCubit>().signInWithSms(_otpCode);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: NewsphoneTheme.primary,
                                      borderRadius: BorderRadius.circular(24.0),
                                      border: Border.all(color: Colors.grey.shade300),
                                    ),
                                    width: double.infinity,
                                    child: Center(
                                      child: Text(
                                        "Επιβεβαίωση & Παραλαβή Κουπονιών",
                                        textAlign: TextAlign.center,
                                        style: NewsphoneTypography.body17SemiBold.copyWith(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),

                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // Implement resend logic here
                                      print("Resend code tapped");
                                    },
                                    child: Text(
                                      "Αποστολή Ξανά",
                                      style: NewsphoneTypography.body13SemiBold
                                          .copyWith(color: buttonColor),
                                    ),
                                  ),
                                  // Placeholder for the timer
                                  Text(
                                    "04:49",
                                    style: NewsphoneTypography.body13SemiBold
                                        .copyWith(color: Colors.grey.shade600),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
              ),
            ],
          );
        },
      ),
    );
  }
}
