import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
              // Use a Stack to place the notch on top of the image
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  // The image is the bottom layer
                  if (widget.deal.dealImage != null)
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: widget.deal.companyImage!,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),

                  // The notch is on top of the image
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
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
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
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ),

              const SizedBox(height: 16),

              // --- CTA Button (like “Δες τον κωδικό”)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child:
                    _isCodeRevealed
                        ? Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white,
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
                            },
                            child: Text(
                              widget.deal.dealCode,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                                letterSpacing: 1.6,
                              ),
                            ),
                          ),
                        )
                        : Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            gradient: const LinearGradient(
                              colors: [Color(0xFF2196F3), Color(0xFFE91E63)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
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
                            child: const Text(
                              "Δες τον κωδικό",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
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
                      const Text(
                        "Όροι και Προϋποθέσεις",
                        style: TextStyle(
                          color: Color(0xff121212),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.deal.terms!,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
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
