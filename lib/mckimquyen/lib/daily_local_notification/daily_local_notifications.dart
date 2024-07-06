import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ketquaxoso/mckimquyen/lib/daily_local_notification/providers/reminder_settings_provider.dart';
import 'package:ketquaxoso/mckimquyen/lib/daily_local_notification/repositories/reminder_repository.dart';
import 'package:ketquaxoso/mckimquyen/lib/daily_local_notification/repositories/shared_prefs_repository.dart';
import 'package:ketquaxoso/mckimquyen/lib/daily_local_notification/ui/daily_local_notification_widget.dart';
import 'package:ketquaxoso/mckimquyen/lib/daily_local_notification/utils/daily_local_notifications_config.dart';
import 'package:ketquaxoso/mckimquyen/lib/daily_local_notification/utils/notification_config.dart';
import 'package:ketquaxoso/mckimquyen/lib/daily_local_notification/utils/styling_config.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Displays a row of toggle buttons for selecting days of the week.
/// Displays a daily-checkbox-button for selecting
/// or deselecting all days of the week.
class DailyLocalNotifications extends StatefulWidget {
  final DailyLocalNotificationsConfig config;
  final NotificationConfig notificationConfig;
  final StylingConfig stylingConfig;

  /// Widget for displaying the "Reminder Title" text
  final Widget reminderTitleText;

  /// Widget for displaying the "Repeat" text on the left
  final Widget reminderRepeatText;

  /// Widget for displaying the "Daily" text for the toggle button on the right
  final Widget reminderDailyText;

  final TextStyle timeNormalTextStyle;
  final TextStyle timeSelectedTextStyle;

  final VoidCallback onNotificationsUpdated;

  /// Constructor for [DailyLocalNotifications]
  const DailyLocalNotifications({
    super.key,
    required this.config,
    required this.notificationConfig,
    required this.stylingConfig,
    required this.reminderTitleText,
    required this.reminderRepeatText,
    required this.reminderDailyText,
    required this.timeNormalTextStyle,
    required this.timeSelectedTextStyle,
    required this.onNotificationsUpdated,
  });

  @override
  State<DailyLocalNotifications> createState() => _DailyLocalNotificationsState();
}

class _DailyLocalNotificationsState extends State<DailyLocalNotifications> {
  late Future<ReminderSettingsProvider> loadDependencies;

  @override
  void initState() {
    super.initState();
    loadDependencies = init();
  }

  /// Creates a [DailyLocalNotifications] widget.
  Future<ReminderSettingsProvider> init() async {
    debugPrint("roy93~ init");
    final reminderRepository = ReminderRepository(
      flutterLocalNotificationsPlugin: FlutterLocalNotificationsPlugin(),
      notificationConfig: widget.notificationConfig,
    );
    debugPrint("roy93~ 1");
    final sharedPrefs = await SharedPreferences.getInstance();
    final sharedPrefsRepository = SharedPrefsRepository(
      sharedPrefs: sharedPrefs,
    );
    debugPrint("roy93~ 2");
    final reminderSettingsProvider = ReminderSettingsProvider(
      reminderRepository: reminderRepository,
      sharedPrefsRepository: sharedPrefsRepository,
      config: widget.config,
      onNotificationsUpdated: widget.onNotificationsUpdated,
    );
    debugPrint("roy93~ 3");
    await reminderSettingsProvider.init();
    debugPrint("roy93~ 4");
    debugPrint("roy93~ reminderSettingsProvider $reminderSettingsProvider");
    return reminderSettingsProvider;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ReminderSettingsProvider>(
      future: loadDependencies,
      builder: (
        BuildContext context,
        AsyncSnapshot<ReminderSettingsProvider> snapshot,
      ) {
        debugPrint("roy93~ snapshot.connectionState ${snapshot.connectionState}");
        debugPrint("roy93~ snapshot ${snapshot.hasData}");
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          return ChangeNotifierProvider<ReminderSettingsProvider>.value(
            value: snapshot.data!,
            child: DailyLocalNotificationWidget(
              reminderTitleText: widget.reminderTitleText,
              reminderRepeatText: widget.reminderRepeatText,
              reminderDailyText: widget.reminderDailyText,
              activeColor: widget.stylingConfig.activeColor,
              inactiveColor: widget.stylingConfig.inactiveColor,
              backgroundColor: widget.stylingConfig.backgroundColor,
              timeNormalTextStyle: widget.timeNormalTextStyle,
              timeSelectedTextStyle: widget.timeSelectedTextStyle,
              contentPadding: widget.stylingConfig.contentPadding,
            ),
          );
        }

        return const SizedBox.shrink();
        // return const Center(
        //   child: CircularProgressIndicator(),
        // );
      },
    );
  }
}
