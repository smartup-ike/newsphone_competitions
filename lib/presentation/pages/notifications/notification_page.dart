import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/functions/date_time_format.dart';
import '../../../data/models/notification.dart';
import '../../../logic/blocs/notifications/notifications_cubit.dart';

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
                if (value == 'delete') {
                  context.read<NotificationCubit>().deleteAllNotifications();
                }
              },
              itemBuilder:
                  (BuildContext context) => <PopupMenuEntry<String>>[
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
              return Card(
                margin: const EdgeInsets.only(bottom: 0.0),
                // Spacing between cards
                elevation: 0,
                // Cards appear flat in the image
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  // This defines the shape
                  borderRadius: BorderRadius.circular(
                    0,
                  ), // This makes the corners rounded
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Νέος Διαγωνισμός!',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        notification.body,
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0, left: 8),
                      child: Text(
                        'ΚΛΗΡΩΣΗ ${notification.endDate != null ? formatDate(notification.endDate!) : ''}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF00A113),
                          // Deep purple color as in the image
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
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
                          onPressed: () {
                            print(
                              'Register for competition: ${notification.competitionId}',
                            );
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
                    Divider(color: Colors.grey),
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
