import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsphone_competitions/core/themes/newsphone_theme.dart';
import 'package:newsphone_competitions/logic/blocs/notifications/notifications_cubit.dart';
import '../../data/models/notification.dart';
import '../pages/notifications/notification_page.dart';
import '../pages/settings/settings_page.dart';

class HomePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback clickNotificationFunction;
  final VoidCallback clickDrawerFunction;

  const HomePageAppBar({
    super.key,
    required this.clickNotificationFunction,
    required this.clickDrawerFunction,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: false,
      floating: true,
      snap: true,
      backgroundColor: NewsphoneTheme.neutralWhite,
      elevation: 0,
      toolbarHeight: 50,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Row(
        children: [
          // Left blue box with "14614"
          Container(
            color: NewsphoneTheme.primary,
            padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
            child: Image.asset(
              'assets/images/logo.png',
              width: 150,
              height: 30,
            ),
          ),

          // Center logo ANT1
          Expanded(
            child: Container(
              color: NewsphoneTheme.neutral90,
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 20,
                bottom: 20,
              ),
              child: Center(
                child: Image.asset(
                  'assets/images/ant1.png',
                  height: 30,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Container(color: NewsphoneTheme.neutralWhite, width: 2),
        ],
      ),
      actions: [
        BlocBuilder<NotificationCubit, List<AppNotification>>(
          builder: (context, notifications) {
            final hasUnread =
                context.read<NotificationCubit>().hasUnreadNotifications;

            return Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotificationsPage(),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 50,
                    decoration: BoxDecoration(
                      color: NewsphoneTheme.neutral90,
                    ),
                    child: const Icon(
                      CupertinoIcons.bell,
                      color: NewsphoneTheme.neutralBlack,
                    ),
                  ),
                ),
                if (hasUnread)
                  Positioned(
                    right: 12,
                    top: 12,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: NewsphoneTheme.deactivate,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsPage()),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            height: 50,
            decoration: BoxDecoration(
              color: NewsphoneTheme.neutral90,
            ),
            child: const Icon(Icons.menu, color: Colors.black),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
