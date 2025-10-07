import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:newsphone_competitions/data/models/contests.dart';

import '../../../../core/functions/date_time_format.dart';

class ContestCard extends StatelessWidget {
  const ContestCard({
    super.key,
    required this.contest,
    required this.clickContentFunction,
  });

  final Contest contest;
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
              child:
                  contest.imageUrl != null
                      ? Image.network(
                        contest.imageUrl!,
                        fit: BoxFit.cover,
                        height: 200,
                      )
                      : Container(
                        height: 200,
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.image,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    contest.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Description
                  Text(
                    contest.instructions ??
                        'Συμμετοχή στον διαγωνισμό για μια μοναδική ευκαιρία να κερδίσεις το έπαθλο!',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF555758),
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),

                  // Info Row (Icons and Text)
                  Wrap(
                    spacing: 16,
                    runSpacing: 8,
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            'assets/images/icons/calendar.svg',
                            width: 20,
                            height: 20,
                            color:
                                contest.dateEnd.isBefore(DateTime.now())
                                    ? Color(0xFFBE0609)
                                    : null,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${contest.dateEnd.isBefore(DateTime.now()) ? 'Κληρώθηκε' : 'Κλήρωση'} ${formatDate(contest.dateEnd)}',
                            style: TextStyle(
                              fontSize: 15,
                              color:
                                  contest.dateEnd.isBefore(DateTime.now())
                                      ? Color(0xFFBE0609)
                                      : Color(0xFF054279),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(width: 20),
                      if (contest.shows.isNotEmpty)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              'assets/images/icons/Vector.svg',
                              width: 20,
                              height: 20,
                            ),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                contest.shows
                                    .map((show) => show.name)
                                    .join(', '),
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF054279),
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
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
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 12.0,
                        ),
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                      child: Text(
                        'Διεκδίκησε το',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize:
                              16, // can also pull from Theme.of(context).textTheme.button
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
}
