import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:newsphone_competitions/data/models/contests.dart';

import '../../../../core/functions/date_time_format.dart';

class ContestCard extends StatelessWidget {
  const ContestCard({
    super.key,
    required this.content,
    required this.clickContentFunction,
  });

  final Contest content;
  final VoidCallback clickContentFunction;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shadowColor: Colors.black.withValues(alpha: 0.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: InkWell(
        onTap: clickContentFunction,
        borderRadius: BorderRadius.circular(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image Section
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20.0),
              ),
              child: Image.network(
                content.imageUrl!,
                fit: BoxFit.cover,
                height: 200,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    content.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Description
                  // ! Change with value from API
                  Text(
                    'Συμμετοχή στον διαγωνισμό για μια μοναδική ευκαιρία να κερδίσεις ...',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF555758),
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),

                  // Info Row (Icons and Text)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildInfoItem(
                        icon: SvgPicture.asset(
                          'assets/images/icons/calendar.svg',
                          width: 20,
                          height: 20,
                        ),
                        text: 'Κλήρωση ${formatDate(content.dateEnd)}',
                      ),
                      _buildInfoItem(
                        icon: SvgPicture.asset(
                          'assets/images/icons/Vector.svg',
                          width: 20,
                          height: 20,
                        ),
                        text: 'Το Πρωϊνό',
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Call-to-action Button
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF08C7F4), Color(0xFF0765CB)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    child: TextButton(
                      onPressed: clickContentFunction,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text(
                        'Δήλωσε Συμμετοχή',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem({required SvgPicture icon, required String text}) {
    return Row(
      children: [
        icon,
        const SizedBox(width: 10),
        Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            color: Color(0xFF054279),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
