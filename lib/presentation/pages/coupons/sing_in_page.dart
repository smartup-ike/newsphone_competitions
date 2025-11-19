import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/themes/newsphone_typography.dart';
import '../../../logic/blocs/auth/auth_cubit.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _phoneController = TextEditingController();
  final _smsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 20,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Εξασφαλίστε τα 10 Κουπόνια σας!',
                          style: NewsphoneTypography.heading5Bold,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Για να ολοκληρωθεί η απόδοση των 10 κουπονιών και να επιβεβαιώσουμε την ταυτότητά σας (ώστε να λάβετε επίσημα τα δώρα σας), παρακαλούμε εισάγετε τον αριθμό του κινητού σας. Θα σας στείλουμε άμεσα έναν 6ψήφιο κωδικό επιβεβαίωσης (OTP) για το επόμενο βήμα.',
                          style: NewsphoneTypography.body13Regular,
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
                            TextField(
                              controller: _phoneController,
                              decoration: InputDecoration(labelText: "Phone"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                print(
                                  'number : ${'+30${_phoneController.text.trim()}'}',
                                );
                                context.read<AuthCubit>().verifyPhone(
                                  '+30${_phoneController.text.trim()}',
                                );
                              },
                              child: Text("Send Code"),
                            ),
                          ],
                        )
                        : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextField(
                              controller: _smsController,
                              decoration: InputDecoration(
                                labelText: "SMS Code",
                              ),
                            ),
                            ElevatedButton(
                              onPressed:
                                  () => context.read<AuthCubit>().signInWithSms(
                                    _smsController.text,
                                  ),
                              child: Text("Sign In"),
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
