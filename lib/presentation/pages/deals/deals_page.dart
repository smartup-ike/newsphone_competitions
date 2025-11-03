import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      backgroundColor: Colors.white,
      body: BlocBuilder<DealsCubit, DealsState>(
        builder: (context, state) {
          if (state is DealsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DealsError) {
            return Center(child: Text(state.message));
          } else if (state is DealsLoaded) {
            return RefreshIndicator(
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
                        backgroundColor: Colors.white,
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
