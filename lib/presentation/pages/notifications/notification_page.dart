import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/functions/date_time_format.dart';
import '../../../data/models/notification.dart';
import '../../../logic/blocs/notifications/notifications_cubit.dart';
import '../contest_content/contest_content_page.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NotificationCubit>().loadNotifications();
      context.read<NotificationCubit>().markAllAsRead();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Ειδοποιήσεις',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: PopupMenuButton<String>(
              icon: const Icon(Icons.more_horiz, color: Colors.black),
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onSelected: (value) {
                if (value == 'read_all') {
                  context.read<NotificationCubit>().markAllAsRead();
                }
                if (value == 'delete') {
                  context.read<NotificationCubit>().deleteAllNotifications();
                }
              },
              itemBuilder:
                  (BuildContext context) => <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: 'read_all',
                      height: 36,
                      // 🔹 Makes the row thinner (default is 48)
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      // tighter padding
                      child: Row(
                        children: const [
                          Icon(
                            Icons.check_box_outlined,
                            color: Colors.black,
                            size: 18,
                          ),
                          // smaller icon
                          SizedBox(width: 6),
                          Text(
                            'Σήμανση όλων ως διαβασμένα',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 14, // smaller font
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'delete',
                      height: 36,
                      // 🔹 Makes the row thinner (default is 48)
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      // tighter padding
                      child: Row(
                        children: const [
                          Icon(Icons.delete, color: Colors.red, size: 18),
                          // smaller icon
                          SizedBox(width: 6),
                          Text(
                            'Διαγραφή όλων',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                              fontSize: 14, // smaller font
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
            ),
          ),
        ],
      ),
      body: BlocBuilder<NotificationCubit, List<AppNotification>>(
        builder: (context, notifications) {
          if (notifications.isEmpty) {
            return const Center(child: Text('Δεν υπάρχουν νέες ειδοποιήσεις.'));
          }
          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              print(notification.competitionId);
              return Card(
                margin: EdgeInsets.zero,
                elevation: 0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Notification content
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Νέος Διαγωνισμός!',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  notification.body,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'ΚΛΗΡΩΣΗ ${notification.endDate != null ? formatDate(notification.endDate!) : ''}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF00A113),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Three dots menu
                          PopupMenuButton<String>(
                            icon: const Icon(
                              Icons.more_horiz,
                              color: Colors.black,
                              size: 20,
                            ),
                            color: Colors.white,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            onSelected: (value) {
                              if (value == 'delete') {
                                context
                                    .read<NotificationCubit>()
                                    .deleteNotification(notification);
                              }
                            },
                            itemBuilder:
                                (context) => <PopupMenuEntry<String>>[
                                  const PopupMenuItem<String>(
                                    value: 'delete',
                                    height: 30,
                                    child: Text('Διαγραφή'),
                                  ),
                                ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 4),
                    // Register button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF08C7F4), Color(0xFF0765CB)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: () async {
                            final content = await context
                                .read<NotificationCubit>()
                                .openContentFromNotifications(
                                  notification.competitionId,
                                );
                            if (content != null) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          ContestContentPage(contest: content),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 20,
                            ),
                            minimumSize: const Size(double.minPositive, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Δήλωσε Συμμετοχή',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Divider at dead bottom
                    const Divider(height: 1, color: Colors.grey),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
