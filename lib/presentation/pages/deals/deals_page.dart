import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsphone_competitions/core/themes/newsphone_theme.dart';
import '../../../core/themes/newsphone_typography.dart';
import '../../../data/services/analytics_service.dart';
import '../../../logic/blocs/deals/deals_cubit.dart';
import 'components/deal_bottom_sheet.dart';
import 'components/deal_card.dart';
import 'components/toast_helper.dart';

class DealsPage extends StatelessWidget {
  const DealsPage({super.key});

  Future<void> _onRefresh(BuildContext context) async {
    await context.read<DealsCubit>().refreshDeals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NewsphoneTheme.neutralWhite,
      body: BlocBuilder<DealsCubit, DealsState>(
        builder: (context, state) {
          if (state is DealsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DealsError) {
            return Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 60,
                      color: NewsphoneTheme.neutral30,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Κάτι πήγε στραβά',
                      style: NewsphoneTypography.heading6Bold.copyWith(
                        color: NewsphoneTheme.neutral30,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is DealsLoaded) {
            return RefreshIndicator(
              color: NewsphoneTheme.primary,
              onRefresh: () => _onRefresh(context),
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: state.deals.length,
                itemBuilder: (context, index) {
                  final deal = state.deals[index];
                  return DealCard(
                    deal: deal,
                    onPressButton: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: NewsphoneTheme.neutralWhite,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder:
                            (_) => DealBottomSheet(
                              deal: deal,
                              onCodeCopied: (String dealCode) async {
                                showToast(
                                  context,
                                  message: "Κωδικός $dealCode αντιγράφηκε!",
                                );
                                await AnalyticsService.basicLogEvent(
                                  'copy_deal_code',
                                  [dealCode],
                                );
                              },
                            ),
                      );
                    },
                  );
                },
              ),
            );
          }
          return const Center(child: Text("No deals available"));
        },
      ),
    );
  }
}
