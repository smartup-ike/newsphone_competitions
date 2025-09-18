import 'package:flutter/material.dart';
import 'package:newsphone_competitions/presentation/pages/contest_content/components/program_button.dart';

import '../../../../data/models/contests.dart';
import 'bottom_modalsheet_callsms.dart';

void showContestChooseProBottomSheet(
  BuildContext context,
  Contest contest,
  VoidCallback onPressDial,
  VoidCallback onPressMessage,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
    ),
    builder: (BuildContext context) {
      return _ContestChooseProContent(
        contest: contest,
        onPressDial: onPressDial,
        onPressMessage: onPressMessage,
      );
    },
  );
}

class _ContestChooseProContent extends StatefulWidget {
  final Contest contest;
  final VoidCallback onPressDial;
  final VoidCallback onPressMessage;

  const _ContestChooseProContent({
    required this.contest,
    required this.onPressDial,
    required this.onPressMessage,
  });

  @override
  State<_ContestChooseProContent> createState() =>
      _ContestChooseProContentState();
}

class _ContestChooseProContentState extends State<_ContestChooseProContent> {
  int selectedIndex = -1;

  // TODO : Here it will take them from the contest model
  final programs = ['Το Πρωίνο', 'Σαββατοκύριακο με τον Μάνεση'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            height: 5.0,
            width: 40.0,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2.5),
            ),
          ),
          const SizedBox(height: 32.0),

          // Title
          const Text(
            'Μέσω ποιας εκπομπής θέλεις να συμμετέχεις στο διαγωνισμό;',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              letterSpacing: 0,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 16.0),

          // Subtitle
          const Text(
            'Επίλεξε την εκπομπή που παρακολουθείς και στης οποίας το διαγωνισμό θέλεις να πάρεις μέρος',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 24.0),

          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.generate(programs.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: ProgramButton(
                  label: programs[index],
                  selected: selectedIndex == index,
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                    showContestPhoneSmsBottomSheet(
                      context,
                      widget.onPressDial,
                      widget.onPressMessage,
                    );
                  },
                ),
              );
            }),
          ),

          const SizedBox(height: 40.0),
        ],
      ),
    );
  }
}
