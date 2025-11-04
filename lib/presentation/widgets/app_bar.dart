import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsphone_competitions/core/themes/newsphone_theme.dart';
import 'package:newsphone_competitions/logic/blocs/notifications/notifications_cubit.dart';
import '../../data/models/notification.dart';

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
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
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
                right: 20,
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
        // Notification Icon with unread dot
        BlocBuilder<NotificationCubit, List<AppNotification>>(
          builder: (context, notifications) {
            final hasUnread =
                context.read<NotificationCubit>().hasUnreadNotifications;

            return Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    top: 5,
                    bottom: 5,
                    right: 3,
                    left: 3,
                  ),
                  decoration: BoxDecoration(color: NewsphoneTheme.neutral90),
                  child: IconButton(
                    icon: const Icon(CupertinoIcons.bell, color: Colors.black),
                    onPressed: clickNotificationFunction,
                  ),
                ),
                if (hasUnread)
                  Positioned(
                    right: 12,
                    top: 12,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),

        // Menu icon
        Container(
          padding: const EdgeInsets.only(top: 5, bottom: 5, right: 3, left: 3),
          decoration: BoxDecoration(color: NewsphoneTheme.neutral90),
          child: IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: clickDrawerFunction,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
