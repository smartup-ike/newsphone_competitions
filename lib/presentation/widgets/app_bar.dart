import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      title: Row(
        children: [
          Image.asset('assets/images/logo.png', height: 27, width: 93),
        ],
      ),
      actions: [
        BlocBuilder<NotificationCubit, List<AppNotification>>(
          builder: (context, notifications) {
            final hasUnread =
                context.read<NotificationCubit>().hasUnreadNotifications;
            return Stack(
              children: [
                IconButton(
                  icon: const Icon(CupertinoIcons.bell, color: Colors.black),
                  onPressed: clickNotificationFunction,
                ),
                if (hasUnread)
                  Positioned(
                    right: 13,
                    top: 13,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      // Adjusted padding for a smaller dot
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(
                          10,
                        ), // Reduced radius for a small dot
                      ),
                      constraints: const BoxConstraints(
                        maxWidth: 15, // Adjusted minWidth
                        maxHeight: 6, // Adjusted minHeight
                      ),
                      child: const Text(
                        '', // Empty text for just a dot
                        style: TextStyle(color: Colors.white, fontSize: 8),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: clickDrawerFunction,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
