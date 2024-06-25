import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';
import 'notification_service.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    print("Task executed: $task");

    final NotificationService notificationService = NotificationService();
    await notificationService.init();
    await notificationService.showNotification(
      "A Chita Faleceu",
      "A chita morreu por falta de atividade.",
    );
    print("Notification shown");
    return Future.value(true);
  });
}
