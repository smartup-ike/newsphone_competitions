import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/notification.dart';
import '../../../logic/blocs/notifications/notifications_cubit.dart';
import 'components/custom_action_chip.dart';

class PreferencesPage extends StatefulWidget {
  const PreferencesPage({super.key});

  @override
  _PreferencesPageState createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: const Color(0xFFF2F4F7),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                floating: false,
                pinned: true,
                centerTitle: true,
                title: Text(
                  'Προτιμήσεις διαγωνισμών',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.inverseSurface,
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(1.0),
                  child: Container(color: Colors.grey[300], height: 1.0),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    const SizedBox(height: 24),
                    const Text(
                      "Τι κατηγορίες διαγωνισμών σας ενδιαφέρουν;",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF121212),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Επιλέξτε τις κατηγορίες διαγωνισμών για τους οποίους θέλετε να λαμβάνετε ειδοποιήσεις.",
                      style: TextStyle(fontSize: 13, color: Color(0xFF333435)),
                    ),
                    const SizedBox(height: 24),
                    BlocBuilder<NotificationCubit, List<AppNotification>>(
                      builder: (context, state) {
                        final cubit = context.read<NotificationCubit>();
                        final selectedTopics = cubit.selectedTopics;
                        final categories = cubit.topics;

                        return Wrap(
                          spacing: 14,
                          runSpacing: 8.0,
                          children:
                              categories.map((category) {
                                final isSelected = selectedTopics.contains(
                                  category.name,
                                );
                                return CustomActionChip(
                                  label: category.description,
                                  isSelected: isSelected,
                                  onPressed: () async {
                                    setState(() => _isLoading = true);
                                    await cubit.toggleTopic(category.name);
                                    setState(() => _isLoading = false);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          !isSelected
                                              ? 'Η κατηγορία "${category.description}" ενεργοποιήθηκε'
                                              : 'Η κατηγορία "${category.description}" απενεργοποιήθηκε',
                                        ),
                                        duration: const Duration(seconds: 2),
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                        );
                      },
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
        if (_isLoading)
          Container(
            color: Colors.black.withValues(alpha: 0.3),
            child: const Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}
