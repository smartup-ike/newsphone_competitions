import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsphone_competitions/presentation/pages/coupons/my_coupons_page.dart';
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
          // User is authenticated → show basic placeholder
          return MyCouponsPage();
        }
      },
    );
  }
}
