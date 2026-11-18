import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsphone_competitions/core/themes/newsphone_theme.dart';
import 'package:newsphone_competitions/logic/blocs/notifications/notifications_cubit.dart';
import '../../data/models/notification.dart';
import '../pages/notifications/notification_page.dart';
import '../pages/settings/settings_page.dart';
import 'package:newsphone_competitions/flavors/flavor_config.dart';
import 'flavor_logo.dart';

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
      backgroundColor: NewsphoneTheme.surface,
      elevation: 0,
      toolbarHeight: 50,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Row(
        children: [
          // Left box: app number logo
          Expanded(
            child: Container(
              color: NewsphoneTheme.appBarLogoBackground,
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: FlavorLogo(
                FlavorConfig.instance.appLogoAsset,
                width: 160,
                height: 30,
              ),
            ),
          ),

          // Centre box: TV channel logo
          Expanded(
            child: Container(
              color: NewsphoneTheme.surfaceSubtle,
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 20,
                bottom: 20,
              ),
              child: Center(
                child: FlavorLogo(
                  FlavorConfig.instance.stationLogoAsset,
                  height: 37,
                  width: 87,
                  fit: BoxFit.fill,
                  color: FlavorConfig.instance.stationLogoColor,
                ),
              ),
            ),
          ),
          Container(color: NewsphoneTheme.surface, width: 2),
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
                    decoration: BoxDecoration(color: NewsphoneTheme.surfaceSubtle),
                    child: Icon(
                      CupertinoIcons.bell,
                      color: NewsphoneTheme.textStrong,
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
                        color: NewsphoneTheme.danger,
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
            decoration: BoxDecoration(color: NewsphoneTheme.surfaceSubtle),
            child: Icon(Icons.menu, color: NewsphoneTheme.contrast),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
