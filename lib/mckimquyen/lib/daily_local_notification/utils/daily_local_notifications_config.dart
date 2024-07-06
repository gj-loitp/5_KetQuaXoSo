class DailyLocalNotificationsConfig {
  /// Translation for weekdays shown for the day toggle buttons
  /// Defaults to ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday',
  /// 'Saturday', 'Sunday']
  final List<String> weekDayTranslations;
  final bool use24HourFormat;
  final bool useCupertinoSwitch;

  /// Constructor for [DailyLocalNotificationsConfig]
  const DailyLocalNotificationsConfig({
    this.weekDayTranslations = const [
      'Thứ 2',
      'Thứ 3',
      'Thứ 4',
      'Thứ 5',
      'Thứ 6',
      'Thứ 7',
      'CN',
    ],
    this.use24HourFormat = true,
    this.useCupertinoSwitch = true,
  });
}
