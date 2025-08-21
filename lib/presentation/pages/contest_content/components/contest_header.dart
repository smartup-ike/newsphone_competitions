import 'package:flutter/material.dart';

class ContestHeader extends StatelessWidget {
  final String? imageUrl;
  const ContestHeader({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F7),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(43.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.asset(
                    imageUrl ?? '',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Image.asset(
                  'assets/proino_logo.png',
                  width: 50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
