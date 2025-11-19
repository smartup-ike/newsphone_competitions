import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsphone_competitions/data/services/api_service.dart';
import 'package:newsphone_competitions/presentation/pages/coupons/sing_in_page.dart';

import '../../../logic/blocs/auth/auth_cubit.dart';

class CouponsPage extends StatelessWidget {
  const CouponsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        if (authState.status == AuthStatus.unknown) {
          return const Center(child: CircularProgressIndicator());
        } else if (authState.status == AuthStatus.unauthenticated) {
          return const SignInPage();
        } else {
          //ApiService().fetchMe('eyJhbGciOiJSUzI1NiIsImtpZCI6IjQ1YTZjMGMyYjgwMDcxN2EzNGQ1Y2JiYmYzOWI4NGI2NzYxMjgyNjUiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vbmV3cGhvbmUtdGVzdCIsImF1ZCI6Im5ld3Bob25lLXRlc3QiLCJhdXRoX3RpbWUiOjE3NjM1NTU4MjQsInVzZXJfaWQiOiJjR21ua05nQ3o5ZjdPdEY3RXFBcVJENzVmbDcyIiwic3ViIjoiY0dtbmtOZ0N6OWY3T3RGN0VxQXFSRDc1Zmw3MiIsImlhdCI6MTc2MzU1NjU1OSwiZXhwIjoxNzYzNTYwMTU5LCJwaG9uZV9udW1iZXIiOiIrMzA2OTA5OTQ2Nzk0IiwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJwaG9uZSI6WyIrMzA2OTA5OTQ2Nzk0Il19LCJzaWduX2luX3Byb3ZpZGVyIjoicGhvbmUifX0.qWSrvcYQfbKdMZ7rhIASPlIWCOe9YUXefhfpArxzmjJtI7_zrDCk9PqseJEApVLUuHTVMwQcembO8IGNw2WE6YBJngo1n76Mbmg15ejp2lmSCjYdS4YX0xgVEcpalrM2Q9rbh6-xkXoT8e3L_nCQD_uh3nuJh2CdtH8XjBFvKLIUXmRrZRgrt-IfE33ORkrhRg99vVNbMfC7z0jNaXSBtm_msxkFIKCf04B6g_4gTeVgQuh8DiQLJR32kaPGgIj6Zj592D9wEha2WtR0vm29Qj1Jo1ob9YAmZZc6DOtdFZq6gdO1pKBblTCll5o6-_vDjwdYXT2XIBN6e22EKmtdGQ');
          // User is authenticated → show basic placeholder
          return const Scaffold(
            body: Center(
              child: Text(
                "User is authenticated! Coupons will be shown here.",
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
      },
    );
  }
}
