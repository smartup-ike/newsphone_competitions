import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:newsphone_competitions/core/themes/newsphone_theme.dart';
import 'package:newsphone_competitions/core/themes/newsphone_typography.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:newsphone_competitions/data/models/contests.dart';

import '../../../../core/functions/date_time_format.dart';

class ContestCard extends StatefulWidget {
  const ContestCard({
    super.key,
    required this.contest,
    required this.clickContentFunction,
  });

  final Contest contest;
  final VoidCallback clickContentFunction;

  @override
  State<ContestCard> createState() => _ContestCardState();
}

class _ContestCardState extends State<ContestCard> {
  final PageController _pageController = PageController();

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: NewsphoneTheme.neutralWhite,
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shadowColor: Colors.black.withValues(alpha: 0.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: InkWell(
        onTap: widget.clickContentFunction,
        borderRadius: BorderRadius.circular(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image Section
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20.0),
              ),
              child: SizedBox(
                height: 220,
                child:
                    (widget.contest.images != null &&
                            widget.contest.images!.isNotEmpty)
                        ? PageView.builder(
                          controller: _pageController,
                          itemCount: widget.contest.images!.length,
                          onPageChanged: (index) {
                            setState(() {
                              _currentPage = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            return FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: widget.contest.images![index].imageUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              fadeInDuration: const Duration(milliseconds: 500),
                              fadeInCurve: Curves.easeIn,
                            );
                          },
                        )
                        : Container(
                          color: NewsphoneTheme.neutral30,
                          child: const Icon(
                            Icons.image,
                            size: 50,
                            color: NewsphoneTheme.neutralWhite,
                          ),
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
                    widget.contest.name,
                    style: NewsphoneTypography.body17Bold,
                  ),
                  const SizedBox(height: 8),
                  // Description
                  Text(
                    widget.contest.instructions ??
                        'Συμμετοχή στον διαγωνισμό για μια μοναδική ευκαιρία να κερδίσεις το έπαθλο!',
                    style: NewsphoneTypography.body13Medium.copyWith(
                      color: NewsphoneTheme.neutral35,
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
                            'assets/images/icons/Calendar.svg',
                            width: 20,
                            height: 20,
                            color:
                                widget.contest.dateEnd.isBefore(DateTime.now())
                                    ? NewsphoneTheme.deactivate
                                    : NewsphoneTheme.primary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${widget.contest.dateEnd.isBefore(DateTime.now()) ? 'Κληρώθηκε' : 'Κλήρωση'} ${formatDate(widget.contest.dateEnd)}',
                            style: NewsphoneTypography.body15Medium.copyWith(
                              color:
                                  widget.contest.dateEnd.isBefore(
                                        DateTime.now(),
                                      )
                                      ? NewsphoneTheme.deactivate
                                      : NewsphoneTheme.primary,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(width: 20),
                      if (widget.contest.shows.isNotEmpty)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              'assets/images/icons/Vector.svg',
                              width: 20,
                              height: 20,
                              color: NewsphoneTheme.primary,
                            ),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                widget.contest.shows
                                    .map((show) => show.name)
                                    .join(', '),
                                style: NewsphoneTypography.body15Medium
                                    .copyWith(color: NewsphoneTheme.primary),
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
                      gradient:
                          widget.contest.dateEnd.isBefore(DateTime.now())
                              ? null
                              : LinearGradient(
                                colors: [
                                  NewsphoneTheme.primary20,
                                  NewsphoneTheme.primary20,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                      color:
                          widget.contest.dateEnd.isBefore(DateTime.now())
                              ? Colors.grey[300]
                              : null,
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    child: TextButton(
                      onPressed: widget.clickContentFunction,
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
                        style: NewsphoneTypography.body16SemiBold.copyWith(
                          color: NewsphoneTheme.neutralWhite,
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
