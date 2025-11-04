import 'package:flutter/material.dart';
import 'package:newsphone_competitions/core/themes/newsphone_theme.dart';

void showToast(
  BuildContext context, {
  String message = "Κωδικός αντιγράφηκε!",
}) {
  OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder:
        (context) => Positioned(
          top: MediaQuery.of(context).size.height * 0.75,
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
                color: NewsphoneTheme.neutralBlack.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Text(
                message,
                style: TextStyle(color: NewsphoneTheme.neutralWhite),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
  );

  Overlay.of(context).insert(overlayEntry);

  Future.delayed(const Duration(seconds: 2), () {
    overlayEntry.remove();
  });
}
