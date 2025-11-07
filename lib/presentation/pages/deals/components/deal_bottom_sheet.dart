import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newsphone_competitions/core/themes/newsphone_theme.dart';
import 'package:newsphone_competitions/core/themes/newsphone_typography.dart';
import 'package:newsphone_competitions/data/services/analytics_service.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../../data/models/deals.dart';

class DealBottomSheet extends StatefulWidget {
  final Deal deal;
  final Function(String dealCode) onCodeCopied;

  const DealBottomSheet({
    super.key,
    required this.deal,
    required this.onCodeCopied,
  });

  @override
  State<DealBottomSheet> createState() => _DealBottomSheetState();
}

class _DealBottomSheetState extends State<DealBottomSheet> {
  bool _isCodeRevealed = false;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.9,
      maxChildSize: 0.95,
      minChildSize: 0.6,
      builder: (_, controller) {
        return SingleChildScrollView(
          controller: controller,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  if (widget.deal.dealImage != null)
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: widget.deal.dealImage!,
                        width: double.infinity,
                        height: 270,
                        fit: BoxFit.fitWidth,
                      ),
                    ),

                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // --- Company Logo
              if (widget.deal.companyImage != null)
                Center(
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: widget.deal.companyImage!,
                    height: 60,
                  ),
                ),

              const SizedBox(height: 27),

              // --- Deal Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  widget.deal.name,
                  style: NewsphoneTypography.heading7Bold,
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 8),

              // --- Deal Details
              if (widget.deal.details != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    widget.deal.details!,
                    textAlign: TextAlign.center,
                    style: NewsphoneTypography.body15Regular.copyWith(
                      color: NewsphoneTheme.neutral35,
                    ),
                  ),
                ),

              const SizedBox(height: 16),

              // --- CTA Button ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child:
                    _isCodeRevealed
                        ? Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: NewsphoneTheme.neutralWhite,
                            border: Border.all(color: Colors.transparent),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0xFF5A44E0),
                                offset: Offset(0, 0),
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            onPressed: () {
                              Clipboard.setData(
                                ClipboardData(text: widget.deal.dealCode),
                              );
                              widget.onCodeCopied(widget.deal.dealCode);
                              AnalyticsService.logCopyDealCode(
                                widget.deal.name,
                              );
                            },
                            child: Text(
                              widget.deal.dealCode,
                              style: NewsphoneTypography.body16Bold.copyWith(
                                color: NewsphoneTheme.neutralBlack,
                                letterSpacing: 1.6,
                              ),
                            ),
                          ),
                        )
                        : Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            gradient: LinearGradient(
                              colors: [
                                NewsphoneTheme.primary,
                                NewsphoneTheme.deactivate,
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: NewsphoneTheme.neutralWhite,
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                _isCodeRevealed = true;
                              });
                            },
                            child: Text(
                              "Δες τον κωδικό",
                              style: NewsphoneTypography.body16Bold.copyWith(
                                color: NewsphoneTheme.neutralWhite,
                              ),
                            ),
                          ),
                        ),
              ),

              const SizedBox(height: 20),

              // --- Terms & Conditions
              if (widget.deal.terms != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Όροι και Προϋποθέσεις",
                        style: NewsphoneTypography.body16Bold,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.deal.terms!,
                        style: NewsphoneTypography.body13Regular,
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }
}
