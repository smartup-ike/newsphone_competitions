import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/blocs/deals/deals_cubit.dart';
import 'components/deal_bottom_sheet.dart';
import 'components/deal_card.dart';

class DealsPage extends StatelessWidget {
  const DealsPage({super.key});

  void _showToast(BuildContext context) {
    OverlayEntry overlayEntry;

    // Create the OverlayEntry widget
    overlayEntry = OverlayEntry(
      builder:
          (context) => Positioned(
            top:
                MediaQuery.of(context).size.height *
                0.75, // Adjust vertical position
            left: MediaQuery.of(context).size.width * 0.1,
            right: MediaQuery.of(context).size.width * 0.1,
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 12.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: const Text(
                  "Κωδικός αντιγράφηκε!",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
    );

    // Insert the toast into the Overlay
    Overlay.of(context).insert(overlayEntry);

    // Remove the toast after a short duration
    Future.delayed(const Duration(seconds: 2)).then((value) {
      overlayEntry.remove();
    });
  }

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
                              onCodeCopied: (String dealCode) {
                                _showToast(context);
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
