import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsphone_competitions/core/themes/newsphone_theme.dart';
import 'package:newsphone_competitions/core/themes/newsphone_typography.dart';
import '../../../core/functions/date_time_format.dart';
import '../../../data/models/notification.dart';
import '../../../logic/blocs/notifications/notifications_cubit.dart';
import '../contest_content/contest_content_page.dart';
import '../deals/components/deal_bottom_sheet.dart';
import '../deals/components/toast_helper.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage>
    with WidgetsBindingObserver {
  final Set<int> _loadingNotifications = {};
  final Set<int> _collapsedImageNotifications = {};

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
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // App came back to foreground
      context.read<NotificationCubit>().loadNotifications();
      context.read<NotificationCubit>().markAllAsRead();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NewsphoneTheme.neutral95,
      appBar: AppBar(
        backgroundColor: NewsphoneTheme.neutralWhite,
        elevation: 0,
        title: Text('Ειδοποιήσεις', style: NewsphoneTypography.body17Bold),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: PopupMenuButton<String>(
              icon: const Icon(
                Icons.more_horiz,
                color: NewsphoneTheme.neutralBlack,
              ),
              color: NewsphoneTheme.neutralWhite,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onSelected: (value) {
                if(value == 'refresh') {
                  context.read<NotificationCubit>().reinitializeHiveAndLoad();
                }
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
                      value: 'refresh',
                      height: 36,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      // tighter padding
                      child: Row(
                        children: [
                          Icon(
                            Icons.refresh,
                            color: NewsphoneTheme.neutralBlack,
                            size: 18,
                          ),
                          // smaller icon
                          SizedBox(width: 6),
                          Text(
                            'Ανανέωση Ειδοποιήσεων',
                            style: NewsphoneTypography.body15Medium.copyWith(
                              color: NewsphoneTheme.neutralBlack,
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'read_all',
                      height: 36,
                      // 🔹 Makes the row thinner (default is 48)
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      // tighter padding
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_box_outlined,
                            color: NewsphoneTheme.neutralBlack,
                            size: 18,
                          ),
                          // smaller icon
                          SizedBox(width: 6),
                          Text(
                            'Σήμανση όλων ως διαβασμένα',
                            style: NewsphoneTypography.body15Medium.copyWith(
                              color: NewsphoneTheme.neutralBlack,
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
                        children: [
                          Icon(
                            Icons.delete,
                            color: NewsphoneTheme.deactivate,
                            size: 18,
                          ),
                          // smaller icon
                          SizedBox(width: 6),
                          Text(
                            'Διαγραφή όλων',
                            style: NewsphoneTypography.body15Medium.copyWith(
                              color: NewsphoneTheme.deactivate,
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
                margin: EdgeInsets.zero,
                elevation: 0,
                color: NewsphoneTheme.neutralWhite,
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
                        vertical: 8.0, // slightly more vertical breathing room
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      (notification.linkedContestId != 0 || notification.linkedDealId != null) ? (notification.type ?? '') == 'contest'
                                          ? 'Νέος Διαγωνισμός!'
                                          : 'Νέα Προσφορά!': notification.title,
                                      style: NewsphoneTypography.body16SemiBold
                                          .copyWith(
                                            color: NewsphoneTheme.neutralBlack,
                                          ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      (notification.linkedContestId != 0 || notification.linkedDealId != null) ? notification.title : notification.body,
                                      style: NewsphoneTypography.body13Regular
                                          .copyWith(
                                            color: NewsphoneTheme.neutral30,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              // Three dots menu
                              PopupMenuButton<String>(
                                icon: const Icon(
                                  Icons.more_horiz,
                                  color: NewsphoneTheme.neutralBlack,
                                  size: 20,
                                ),
                                padding: const EdgeInsets.all(8.0),
                                color: NewsphoneTheme.neutralWhite,
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
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                formatDate(notification.sentAt),
                                style: NewsphoneTypography.body12Bold
                                    .copyWith(color: NewsphoneTheme.primary),
                              ),
                              if (notification.imageUrl != null && notification.imageUrl!.isNotEmpty)
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (_collapsedImageNotifications.contains(notification.id)) {
                                        _collapsedImageNotifications.remove(notification.id);
                                      } else {
                                        _collapsedImageNotifications.add(notification.id);
                                      }
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 12.0, right: 6.0, top: 4.0, bottom: 4.0),
                                    child: Icon(
                                      _collapsedImageNotifications.contains(notification.id)
                                          ? Icons.keyboard_arrow_down
                                          : Icons.keyboard_arrow_up,
                                      size: 24,
                                      color: NewsphoneTheme.primary,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Premium Image UI
                    if (notification.imageUrl != null && notification.imageUrl!.isNotEmpty && !_collapsedImageNotifications.contains(notification.id))
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: AspectRatio(
                              aspectRatio: 16 / 9,
                              child: Image.network(
                                notification.imageUrl!,
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Container(
                                    color: NewsphoneTheme.neutral10,
                                    child: const Center(
                                      child: CircularProgressIndicator.adaptive(),
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
                              ),
                            ),
                          ),
                        ),
                      ),

                    const SizedBox(height: 4),
                    // Register button
                    (notification.linkedContestId != 0 || notification.linkedDealId != null) ? Row(

                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              gradient: LinearGradient(
                                colors: [
                                  NewsphoneTheme.primary20,
                                  NewsphoneTheme.primary20,
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                            child: ElevatedButton(
                              onPressed:
                                  _loadingNotifications.contains(
                                        notification.linkedContestId,
                                      )
                                      ? null
                                      : () async {
                                        setState(() {
                                          _loadingNotifications.add(
                                            notification.linkedContestId ?? -1,
                                          );
                                        });

                                        final result = await context
                                            .read<NotificationCubit>()
                                            .openContentFromNotifications(
                                              notification.linkedContestId,
                                              notification.linkedDealId,
                                              notification.type,
                                            );

                                        if (result != null) {
                                          if (notification.type == 'contest') {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder:
                                                    (context) =>
                                                        ContestContentPage(
                                                          contest: result,
                                                        ),
                                              ),
                                            );
                                          } else {
                                            showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              backgroundColor:
                                                  NewsphoneTheme.neutralWhite,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.vertical(
                                                          top: Radius.circular(
                                                            20,
                                                          ),
                                                        ),
                                                  ),
                                              builder:
                                                  (_) => DealBottomSheet(
                                                    deal: result,
                                                    onCodeCopied: (
                                                      String dealCode,
                                                    ) {
                                                      showToast(
                                                        context,
                                                        message:
                                                            "Κωδικός $dealCode αντιγράφηκε!",
                                                      );
                                                    },
                                                  ),
                                            );
                                          }
                                        }

                                        setState(() {
                                          _loadingNotifications.remove(
                                            notification.linkedContestId ?? -1,
                                          );
                                        });
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
                              child: Text(
                                (notification.linkedContestId != 0 || notification.linkedDealId != null) ? (notification.type ?? '') == 'contest'
                                    ? 'Δήλωσε Συμμετοχή'
                                    : 'Δές Προσφορά!': 'Δήλωσε Συμμετοχή',
                                style: NewsphoneTypography.body13Bold.copyWith(
                                  color: NewsphoneTheme.neutralWhite,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (_loadingNotifications.contains(
                          notification.linkedContestId,
                        ))
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: NewsphoneTheme.primary,
                            ),
                          ),
                      ],
                    ): const SizedBox(),
                    const SizedBox(height: 8),
                    // Divider at dead bottom
                    const Divider(height: 1, color: NewsphoneTheme.neutral30),
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
