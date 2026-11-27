import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Shows an app-specific logo from [FlavorConfig]. Supports .png/.jpg and
/// .svg, so each app can ship whichever format it has.
class FlavorLogo extends StatelessWidget {
  const FlavorLogo(
    this.asset, {
    super.key,
    this.width,
    this.height,
    this.fit,
    this.color,
    this.fallback,
  });

  final String asset;
  final double? width;
  final double? height;
  /// Same meaning as [Image.fit]; null keeps Image's default.
  final BoxFit? fit;

  /// Only used for .svg: paints the logo in one color.
  final Color? color;

  /// Shown if the image file is missing.
  final Widget? fallback;

  @override
  Widget build(BuildContext context) {
    if (asset.toLowerCase().endsWith('.svg')) {
      return SvgPicture.asset(
        asset,
        width: width,
        height: height,
        fit: fit ?? BoxFit.contain,
        colorFilter:
            color == null ? null : ColorFilter.mode(color!, BlendMode.srcIn),
      );
    }
    return Image.asset(
      asset,
      width: width,
      height: height,
      fit: fit,
      errorBuilder:
          fallback == null ? null : (context, error, stackTrace) => fallback!,
    );
  }
}
