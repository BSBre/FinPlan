import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:finplan/utilities/notification_utilities.dart';

Future<void> createNotification(String title, String description) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: "basic_channel",
      title: "${Emojis.money_money_bag + Emojis.money_dollar_banknote} + $title",
      body: description,
      notificationLayout: NotificationLayout.BigText,
    ),
  );
}

Future<void> createRemainderNotification({required String title, required String description,required int? selectedHour, required int? selectedMinute, required int? selectedYear, required int? selectedMonth, required int? selectedDay}) async {
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: "scheduled_channel",
        title: "${Emojis.money_money_bag + Emojis.money_dollar_banknote} + $title",
        body: description,
        notificationLayout: NotificationLayout.BigText,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'DISMISS',
          label: "Dismiss",
        ),
      ],
    schedule: NotificationCalendar(
      repeats: false,
      year: selectedYear,
      month: selectedMonth,
      day: selectedDay,
      hour: selectedHour,
      minute: selectedMinute,
      second: 0,
      millisecond: 0,
    ),
  );
}
